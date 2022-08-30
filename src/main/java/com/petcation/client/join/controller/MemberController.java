package com.petcation.client.join.controller;

import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tiles.request.Request;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.expression.ParseException;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.petcation.client.join.service.MemberService;
import com.petcation.client.join.vo.MemberVO;
import com.petcation.client.kakao.controller.KakaoController;
import com.petcation.client.naver.controller.NaverLoginDTO;


@Controller
@RequestMapping(value = "/member")
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService mservice;

	@Autowired(required = true)
	private BCryptPasswordEncoder encoder;

	@Autowired
	private JavaMailSender mailSender;
	
    /* NaverLoginDTO */
    private NaverLoginDTO naverLoginDTO;
    private String apiResult = null;
    
	/*
	 * final static String GOOGLE_AUTH_BASE_URL =
	 * "https://accounts.google.com/o/oauth2/v2/auth"; final static String
	 * GOOGLE_TOKEN_BASE_URL = "https://oauth2.googleapis.com/token"; final static
	 * String GOOGLE_REVOKE_TOKEN_BASE_URL = "https://oauth2.googleapis.com/revoke";

	@Value("${api.client_id}")
	String clientId;
	@Value("${api.client_secret}")
	String clientSecret;
	 */

    @Autowired
    private void setNaverLoginDTO(NaverLoginDTO naverLoginDTO) {
        this.naverLoginDTO = naverLoginDTO;
    }

	// 회원가입 페이지 이동
	@RequestMapping(value = "join", method = RequestMethod.GET)
	public void joinGET() {
		
		logger.info("회원가입 페이지 진입");
	}
	
	@RequestMapping(value = "mailSuccess", method = RequestMethod.GET)
	public void mailSuccessGET() {
		
		logger.info("임시비밀번호 발송 완료");
		
	}
	@RequestMapping(value = "mailFail", method = RequestMethod.GET)
	public void mailFailGET() {
		
		logger.info("임시비밀번호 발송 실패");
		
	}

	@RequestMapping(value = "findFail", method = RequestMethod.GET)
	public void findFailGET() {
		
		logger.info("아이디찾기 실패");
		
	}

	@RequestMapping(value = "showId", method = RequestMethod.GET)
	public void userFindTestGET() {
		
		logger.info("아이디 찾기 결과 페이지");
		
	}
	 
	// 네이버 로그인 & 회원정보(이름) 가져오기
		@RequestMapping(value = "/naverLogin", produces = "application/json;charset=utf-8", method = { RequestMethod.GET,
				RequestMethod.POST })
		public ModelAndView naverLogin(@RequestParam String code, @RequestParam String state, HttpSession session)
				throws Exception {
			ModelAndView mav = new ModelAndView();
			OAuth2AccessToken oauthToken;
			oauthToken = naverLoginDTO.getAccessToken(session, code, state);

			// 로그인한 사용자의 모든 정보가 JSON타입으로 저장되어 있음
			apiResult = naverLoginDTO.getUserProfile(oauthToken);

			// 내가 원하는 정보 (이름)만 JSON타입에서 String타입으로 바꿔 가져오기 위한 작업
			JSONParser parser = new JSONParser();
			Object obj = null;
			try {
				obj = parser.parse(apiResult);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			JSONObject jsonobj = (JSONObject) obj;
			JSONObject response = (JSONObject) jsonobj.get("response");
			String nname = (String) response.get("name");
			String nemail = (String) response.get("email");
			String nphone = (String) response.get("mobile");
			String ngender = (String) response.get("gender");
			String nbirthday = (String) response.get("birthday");
			String nage = (String) response.get("age");
			String nimage = (String) response.get("profile_image");

			// 로그인&아웃 하기위한 세션값 주기
			session.setAttribute("nname", nname);
			session.setAttribute("nemail", nemail);
			session.setAttribute("ngender", ngender);
			session.setAttribute("nbirthday", nbirthday);
			session.setAttribute("nage", nage);
			session.setAttribute("nimage", nimage);
			session.setAttribute("nphone", nphone);

			// 네이버 로그인 성공 페이지 View 호출
			mav.setViewName("main");
			return mav;
		}// end naverLogin()
	

	/**
	 * Authentication Code를 전달 받는 엔드포인트
	 **/
	/*
	 * @GetMapping("/googleLogin") public String googleAuth(Model
	 * model, @RequestParam(value = "code") String authCode) throws Exception {
	 * 
	 * //HTTP Request를 위한 RestTemplate RestTemplate restTemplate = new
	 * RestTemplate();
	 * 
	 * //Google OAuth Access Token 요청을 위한 파라미터 세팅 GoogleOAuthRequest
	 * googleOAuthRequestParam =
	 * GoogleOAuthRequest.builder().clientId(clientId).clientSecret(clientSecret).
	 * code(authCode).redirectUri("http://localhost:8080/member/googleLogin").
	 * grantType("authorization_code").build();
	 * 
	 * 
	 * //JSON 파싱을 위한 기본값 세팅 //요청시 파라미터는 스네이크 케이스로 세팅되므로 Object mapper에 미리 설정해준다.
	 * ObjectMapper mapper = new ObjectMapper();
	 * mapper.setPropertyNamingStrategy(PropertyNamingStrategy.SNAKE_CASE);
	 * mapper.setSerializationInclusion(Include.NON_NULL);
	 * 
	 * logger.info("여기까진 찍히는데");
	 * 
	 * //AccessToken 발급 요청 ResponseEntity<String> resultEntity =
	 * restTemplate.postForEntity(GOOGLE_TOKEN_BASE_URL, googleOAuthRequestParam,
	 * String.class);
	 * 
	 * 
	 * //Token Request GoogleOAuthResponse result =
	 * mapper.readValue(resultEntity.getBody(), new
	 * TypeReference<GoogleOAuthResponse>() { });
	 * 
	 * 
	 * //ID Token만 추출 (사용자의 정보는 jwt로 인코딩 되어있다) String jwtToken =
	 * result.getIdToken(); logger.info(jwtToken); String requestUrl =
	 * UriComponentsBuilder.fromHttpUrl("https://oauth2.googleapis.com/tokeninfo")
	 * .queryParam("id_token", jwtToken).encode().toUriString();
	 * 
	 * String resultJson = restTemplate.getForObject(requestUrl, String.class);
	 * 
	 * Map<String,String> userInfo = mapper.readValue(resultJson, new
	 * TypeReference<Map<String, String>>(){}); model.addAllAttributes(userInfo);
	 * model.addAttribute("token", result.getAccessToken());
	 * 
	 * return "/"; }
	 */

//	/**
//	 * 토큰 무효화 
//	 **/
//	@GetMapping("google/revoke/token")
//	public Map<String, String> revokeToken(@RequestParam(value = "token") String token) throws JsonProcessingException {
//
//		Map<String, String> result = new HashMap<>();
//		RestTemplate restTemplate = new RestTemplate();
//		final String requestUrl = UriComponentsBuilder.fromHttpUrl(GOOGLE_REVOKE_TOKEN_BASE_URL)
//				.queryParam("token", token).encode().toUriString();
//		
//		String resultJson = restTemplate.postForObject(requestUrl, null, String.class);
//		result.put("result", "success");
//		result.put("resultJson", resultJson);
//
//		return result;
//
//	}
		
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public ModelAndView memberLoginForm(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		/* 네아로 인증 URL을 생성하기 위하여 getAuthorizationUrl을 호출 */
		String naverAuthUrl = naverLoginDTO.getAuthorizationUrl(session);
		//String naverAuthUrl = naverLoginDTO.getAuthorizationUrl(session);
		String kakaoUrl = KakaoController.getAuthorizationUrl(session);

		/* 생성한 인증 URL을 View로 전달 */
		mav.setViewName("member/login");
		// 네이버 로그인
		mav.addObject("naver_url", naverAuthUrl);
		// 카카오 로그인
		mav.addObject("kakao_url", kakaoUrl);
		
		return mav;
	}// end memberLoginForm()

	
	@RequestMapping(value = "terms1", method = RequestMethod.GET)
	public void terms1GET() {
		
		logger.info("약관 페이지 진입");
	}
	
	@RequestMapping(value = "terms2", method = RequestMethod.GET)
	public void terms2GET() {
		
		logger.info("약관 페이지 진입2");
	}

	// 아이디 찾기 폼
	@RequestMapping(value = "findId", method = RequestMethod.GET)
	public void findIdGET() {

		logger.info("id 찾기 페이지 진입");

	}

	// 비밀번호 찾기 폼
	@RequestMapping(value = "findPw", method = RequestMethod.GET)
	public void findPwGET() {

		logger.info("비밀번호 찾기 페이지 진입");

	}

	@RequestMapping(value = "register", method = RequestMethod.GET)
	public void registerGET() {
		logger.info("회원가입 완료");
	}

	@RequestMapping(value = "test", method = RequestMethod.GET)
	public void testGET() {

		logger.info("테스트 페이지 진입");

	}

	// 회원가입
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String joinPOST(MemberVO member) throws Exception {

		String rawPw = ""; // 인코딩 전 비밀번호
		String encodePw = ""; // 인코딩 후 비밀번호

		rawPw = member.getUser_pw(); // 비밀번호 데이터 얻음
		encodePw = encoder.encode(rawPw); // 비밀번호 인코딩
		member.setUser_pw(encodePw); // 인코딩된 비밀번호 member객체에 다시 저장

		/* 회원가입 쿼리 실행 */
		mservice.memberJoin(member);

		return "redirect:/member/register";
	}

	// 아이디 중복 검사
	@RequestMapping(value = "/memberIdChk", method = RequestMethod.POST)
	@ResponseBody
	public String memberIdChkPOST(String user_id) throws Exception {

		// logger.info("memberIdChk() 진입");
		int result = mservice.idCheck(user_id);

		logger.info("결과값 = " + result);

		if (result != 0) {

			return "fail"; // 중복 아이디가 존재

		} else {

			return "success"; // 중복 아이디 x

		}

	} // memberIdChkPOST() 종료
	
	// 가입 이메일 중복 검사
	@RequestMapping(value = "/memberEmailChk", method = RequestMethod.POST)
	@ResponseBody
	public String memberEmailChkPOST(String user_email) throws Exception {
		
		// logger.info("memberIdChk() 진입");
		int result = mservice.emailCheck(user_email);
		
		logger.info("결과값 = " + result);
		
		if (result != 0) {
			
			return "fail"; // 중복 이메일이 존재
			
		} else {
			
			return "success"; // 중복 이메일이 x
			
		}
		
	} 

	// 가입 휴대폰번호 중복 검사
	@RequestMapping(value = "/memberPhoneChk", method = RequestMethod.POST)
	@ResponseBody
	public String memberPhoneChkPOST(String user_phone) throws Exception {
		
		// logger.info("memberIdChk() 진입");
		int result = mservice.phoneCheck(user_phone);
		
		logger.info("결과값 = " + result);
		
		if (result != 0) {
			
			return "fail"; // 중복 전화번호가 존재
			
		} else {
			
			return "success"; // 중복 전화번호가 x
			
		}
		
	} 
	
	/* 이메일 인증 */
	@RequestMapping(value = "/mailCheck", method = RequestMethod.GET)
	@ResponseBody
	public String mailCheckGET(String email) throws Exception {

		/* 뷰(View)로부터 넘어온 데이터 확인 */
		logger.info("이메일 데이터 전송 확인");
		logger.info("인증번호 : " + email);

		/* 인증번호(난수) 생성 */
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		logger.info("인증번호 " + checkNum);

		/* 이메일 보내기 */
		String setFrom = "sa__s2@naver.com";
		String toMail = email;
		String title = "회원가입 인증 이메일 입니다.";
		String content = "PETCATION을 방문해주셔서 감사합니다." + "<br><br>" + "인증 번호는 " + checkNum + "입니다." + "<br>"
				+ "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";

		try {

			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);

		} catch (Exception e) {
			e.printStackTrace();
		}

		String num = Integer.toString(checkNum);
		return num;
	}

	/* 로그인 */
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String loginPOST(HttpServletRequest request, MemberVO member, RedirectAttributes rttr) throws Exception {

		HttpSession session = request.getSession();
		String rawPw = "";
		String encodePw = "";

		MemberVO vo = mservice.memberLogin(member); // 제출한아이디와 일치하는 아이디 있는지

		if (vo != null) { // 일치하는 아이디 존재시

			rawPw = member.getUser_pw(); // 사용자가 제출한 비밀번호
			encodePw = vo.getUser_pw(); // 데이터베이스에 저장한 인코딩된 비밀번호

			if (true == encoder.matches(rawPw, encodePw)) { // 비밀번호 일치여부 판단

				vo.setUser_pw(""); // 인코딩된 비밀번호 정보 지움
				session.setAttribute("lmember", vo); // session에 사용자의 정보 저장
			    // 세션 시간을 무한대로 설정
			    session.setMaxInactiveInterval(-1);
				return "redirect:/"; // 메인페이지 이동

			} else {

				rttr.addFlashAttribute("result", 0);
				return "redirect:/member/login"; // 로그인 페이지로 이동

			}

		} else { // 일치하는 아이디가 존재하지 않을 시 (로그인 실패)

			rttr.addFlashAttribute("result", 0);
			return "redirect:/member/login"; // 로그인 페이지로 이동

		}

	}

	/* 비동기방식 로그아웃 메서드 */
	@RequestMapping(value = "logout", method = RequestMethod.POST)
	@ResponseBody
	public void logoutPOST(HttpServletRequest request) throws Exception {

		logger.info("비동기 로그아웃 메서드 진입");

		HttpSession session = request.getSession();

		session.invalidate();
		
	}
	
	@RequestMapping(value="/searchPhone", method=RequestMethod.POST)
	public String searchPhonePost(MemberVO member, Model model) throws Exception {
		
		logger.info("값이 넘겨졌나?" + member.getUser_phone());
		String msg = "";
		
		//기존 db에 아이디와 이메일이 일치하는지 확인하기
		MemberVO vo = mservice.searchPhone(member);
		
				
		if(vo != null) {
			String user_id = vo.getUser_id();
			model.addAttribute("user_id", user_id);
			logger.info(user_id);
			return "/member/showId";
		}
		
		else {
			return "redirect:/member/findFail";
		}
		
	}	  
	
	  @RequestMapping(value="/searchEmail", method=RequestMethod.POST)
	  public String searchEmailPost(MemberVO member) throws Exception {
		  
		logger.info("값이 넘겨졌나?" + member.getUser_email());
		String pwd = "";
		
		//기존 db에 아이디와 이메일이 일치하는지 확인하기
		MemberVO vo = mservice.searchEmail(member);

		if(vo != null) {
			//임시비밀번호를 발급한다
			UUID uid = UUID.randomUUID();
			pwd = uid.toString().substring(0,10);

			String encPw = encoder.encode(pwd);
			vo.setUser_pw(encPw); //암호화 시킨 비번 저장
			mservice.updatePw(vo);


			String toMail = vo.getUser_email();
			String content = pwd;
			return "redirect:/member/pwdConfirmMail/"+toMail+"/"+content+"/"; 
		}
		
		else {
			return "redirect:/member/mailFail";
		}

	  }	  

		//비밀번호 분실시에 임시 비밀번호를 발송하기 위한 메일설정 , GET방식
		@RequestMapping(value="/pwdConfirmMail/{toMail}/{content}/", method=RequestMethod.GET)
		public String PwdConfirmMailFormGet(@PathVariable String toMail, @PathVariable String content) throws Exception {
			
			/* 이메일 보내기 */
			String setFrom = "sa__s2@naver.com";
			String title = "비밀번호 확인 메일입니다.";
			String pwd = content;
			content = "PETCATION에서 발송된 메일입니다.\n아래 임시 비밀번호를 보내오니 사이트에 접속하셔서 비밀번호를 변경하세요.\n";
			try {

				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(message, true,"UTF-8");

				//메일 보관함에 저장
				helper.setFrom(setFrom);
				helper.setTo(toMail);
				helper.setSubject(title);
				//messageHelper.setText(content);
				
				//메세지 내용과 함께 사진을 전송
				content = content.replace("\n", "<br/>");
				content += "<font color=red>"+ pwd + "</font><br>";
				content += "<br><hr><h3>PECATION입니다.<h3><hr><br>";
//				content += "<p><img src=\"/resources/images/common/pa.png\" width='250px'></p><hr>";
				content += "<p>오늘도 행복한 시간되세요! </p>";
				helper.setText(content, true);
				//FileSystemResource file = new FileSystemResource(new File("C:/Users/Eunbi/Downloads/images/dog3.jpg"));
				//helper.addInline("dog3.jpg", file);
				
				//메일과 함께 첨부파일 전송
//				FileSystemResource mfile = new FileSystemResource(new File("C:/Users/Eunbi/Downloads/images/dog2.jpg"));
//				messageHelper.addAttachment("1.jpg", mfile);
				
				//메세지 내용과 함께 사진을 전송
				mailSender.send(message); //실제 메일 전송
			} catch (MessagingException e) {
				e.printStackTrace();
			}
			//msgFlag = "OK";
			return "redirect:/member/mailSuccess";
		}
		
		
		@RequestMapping(value = "/kakaoLogin", produces = "application/json", method = { RequestMethod.GET,
				RequestMethod.POST })
		public ModelAndView kakaoLogin(@RequestParam("code") String code, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
			ModelAndView mav = new ModelAndView();
			// 결과값을 node에 담아줌
			JsonNode node = KakaoController.getAccessToken(code);
			// accessToken에 사용자의 로그인한 모든 정보가 들어있음
			JsonNode accessToken = node.get("access_token");
			// 사용자의 정보
			JsonNode userInfo = KakaoController.getKakaoUserInfo(accessToken);
			String kemail = null;
			String kname = null;
			String kgender = null;
			String kbirthday = null;
			String kage = null;
			String kimage = null;
			// 유저정보 카카오에서 가져오기 Get properties
			JsonNode properties = userInfo.path("properties");
			JsonNode kakao_account = userInfo.path("kakao_account");
			kemail = kakao_account.path("email").asText();
			kname = properties.path("nickname").asText();
			kimage = properties.path("profile_image").asText();
			kgender = kakao_account.path("gender").asText();
			kbirthday = kakao_account.path("birthday").asText();
			kage = kakao_account.path("age_range").asText();
			session.setAttribute("kemail", kemail);
			session.setAttribute("kname", kname);
			/* session.setAttribute("kimage", kimage); */
			session.setAttribute("kgender", kgender);
			session.setAttribute("kbirthday", kbirthday);
			session.setAttribute("kage", kage);
			mav.setViewName("main");
			return mav;
		}// end kakaoLogin()
}
	  

	 