package com.example.demo9.controller;

import com.example.demo9.common.PageVO;
import com.example.demo9.common.Pagination;
import com.example.demo9.constant.UserDel;
import com.example.demo9.dto.MemberDto;
import com.example.demo9.entity.Member;
import com.example.demo9.repository.MemberRepository;
import com.example.demo9.service.MemberService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.net.URLEncoder;
import java.util.List;
import java.util.Optional;

@Controller
@RequiredArgsConstructor
@RequestMapping("/member")
public class MemberController {

    private final MemberService memberService;
    private final MemberRepository memberRepository;
    private final Pagination pagination;

    @Autowired
    PasswordEncoder passwordEncoder;

    @GetMapping("/memberLogin")
    public String memberLoginGet() {
        return "member/memberLogin";
    }

    @GetMapping("/memberJoin")
    public String memberJoinGet(Model model) {
        model.addAttribute("memberDto", new MemberDto());
        return "member/memberJoin";
    }

    @GetMapping("/memberLoginOk")
    public String memberLoginOkGet(RedirectAttributes rttr,
                                   HttpServletRequest request,
                                   HttpServletResponse response,
                                   Authentication authentication,
                                   HttpSession session) {
        String email = authentication.getName();
        System.out.println("로그인한 email : " + email);
//        String name = memberService.getMemberEmailCheck(email).get().getName();
//        String strLevel = memberService.getMemberEmailCheck(email).get().getRole().toString();
        Optional<Member> opMember = memberService.getMemberEmailCheck(email);

        // 등급 정보 처리
        String strLevel = opMember.get().getRole().toString();
        if(strLevel.equals("ADMIN")) strLevel = "관리자";
        else if(strLevel.equals("OPERATOR")) strLevel = "운영자";
        else if(strLevel.equals("USER")) strLevel = "정회원";

        // Http세션에 필요한 정보 저장
        session.setAttribute("sName", opMember.get().getName());
        session.setAttribute("strLevel", strLevel);

        rttr.addFlashAttribute("message", opMember.get().getName() + "님 로그인 되셨습니다.");
        return "redirect:/member/memberMain";
    }

//    @GetMapping("/login/error")
//    public  String loginErrorGet(RedirectAttributes rttr) {
//        rttr.addFlashAttribute("loginErrorMsg", "아이디 또는 비밀번호가 일치하지 않습니다.");
//        return "redirect:/member/memberLogin";
//    }

    @GetMapping("/login/error")
    public  String loginErrorGet() {
        return "redirect:/message/memberDelOk";
    }

    @GetMapping("/memberLogout")
    public String memberLogoutGet(Authentication authentication,
                                  HttpServletRequest request,
                                  HttpServletResponse response,
                                  //RedirectAttributes rttr,
                                  HttpSession session) {
        String name = session.getAttribute("sName").toString();
        if(authentication != null) {
            //rttr.addFlashAttribute("message", name + "님 로그아웃 되었습니다.");
            session.invalidate();
            new SecurityContextLogoutHandler().logout(request, response, authentication);
        }
//        return "redirect:/member/memberLogin";
        return "redirect:/message/memberLogout?name="+ URLEncoder.encode(name);
//        return "redirect:/message/memberLogout?name="+name;
    }

    @PostMapping("/memberJoin")
    public String memberJoinPost(RedirectAttributes rttr,
                                 @Valid MemberDto dto,
                                 BindingResult bindingResult) {
        if(bindingResult.hasErrors()) {
            return "member/memberJoin";
        }
        try {
            Member member = Member.dtoToEntity(dto, passwordEncoder);
            Member memberRes = memberService.saveMember(member);
            System.out.println("memberRes==>" + memberRes);
            rttr.addFlashAttribute("message", "회원에 가입되었습니다.");
            return "redirect:/member/memberLogin";
        } catch (IllegalStateException e) {
            rttr.addFlashAttribute("message", e.getMessage());
            return "redirect:/member/memberJoin";
        }


    }

    @GetMapping("/memberMain")
    public String memberMainGet() {
        return "member/memberMain";
    }

    @GetMapping("/memberList")
    public String memberListGet(Model model, PageVO pageVO) {
        pageVO.setSection("member");
        pageVO = pagination.pagination(pageVO);
        model.addAttribute("pageVO", pageVO);
        return "member/memberList";
    }

    @GetMapping("/memberPwdCheck/{flag}")
    public String memberPwdCheckGet(Model model, @PathVariable String flag) {
        // CSRF Token  처리(AJax에서 post처리시)
        model.addAttribute("userCsrf", true);
        model.addAttribute("flag", flag);
        return "member/memberPwdCheck";
    }

    @ResponseBody
    @PostMapping("/memberPwdCheck")
    public int memberPwdCheckPost(String pwd, String email) {
        Optional<Member> member = memberRepository.findByEmail(email);
        if(passwordEncoder.matches(pwd, member.get().getPassword())) return 1;
        else return 0;
    }

    @PostMapping("/memberPwdChange")
    public String memberPwdChangePost(String email,
                                      @RequestParam(name="newPwd", defaultValue = "", required = false) String pwd) {
        Member member = memberRepository.findByEmail(email).orElseThrow();
        member.setPassword(passwordEncoder.encode(pwd));
        memberRepository.save(member);
        return "redirect:/message/memberPwdChangeOk";
    }

    @GetMapping("/memberUpdate")
    public String memberUpdateGet(Model model, String email, Authentication authentication) {
        Optional<Member> opMember = memberRepository.findByEmail(authentication.getName());
        MemberDto dto = MemberDto.entityToDto(opMember);
//        model.addAttribute("memberDto", dto);
        model.addAttribute("dto", dto);
        return "member/memberUpdate";
    }

    @PostMapping("/memberUpdate")
    public String memberUpdatePost(String name, String address,
                                   Authentication authentication,
//                                   @Valid MemberDto memberDto,
                                   @Valid @ModelAttribute("dto") MemberDto dto,  //html 문서에서 'memberDto' 가 아닌 'dto'로 받을경우
                                   BindingResult bindingResult) {
        if(bindingResult.hasErrors()) {
            return "member/memberUpdate";
        }

        String email = authentication.getName();
        Member member = memberRepository.findByEmail(email).orElseThrow();
        member.setName(name);
        member.setAddress(address.trim());
        memberRepository.save(member);
        return "redirect:/message/memberUpdateOk?email="+email;
    }

    @GetMapping("/memberDelete")
    public String memberDeleteGet(Authentication authentication, HttpSession session) {
        String email = authentication.getName();
        Member member = memberRepository.findByEmail(email).orElseThrow();
        member.setUserDel(UserDel.OK);
        memberRepository.save(member);
        session.setAttribute("sName", "회원 탈퇴 되셨습니다. ");
        return "redirect:/member/memberLogout";
    }







}
