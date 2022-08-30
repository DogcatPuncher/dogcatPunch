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

	// ȸ������ ������ �̵�
	@RequestMapping(value = "join", method = RequestMethod.GET)
	public void joinGET() {
		
		logger.info("ȸ������ ������ ����");
	}
	
	@RequestMapping(value = "mailSuccess", method = RequestMethod.GET)
	public void mailSuccessGET() {
		
		logger.info("�ӽú�й�ȣ �߼� �Ϸ�");
		
	}
	@RequestMapping(value = "mailFail", method = RequestMethod.GET)
	public void mailFailGET() {
		
		logger.info("�ӽú�й�ȣ �߼� ����");
		
	}

	@RequestMapping(value = "findFail", method = RequestMethod.GET)
	public void findFailGET() {
		
		logger.info("���̵�ã�� ����");
		
	}

	@RequestMapping(value = "showId", method = RequestMethod.GET)
	public void userFindTestGET() {
		
		logger.info("���̵� ã�� ��� ������");
		
	}
	 
	// ���̹� �α��� & ȸ������(�̸�) ��������
		@RequestMapping(value = "/naverLogin", produces = "application/json;charset=utf-8", method = { RequestMethod.GET,
				RequestMethod.POST })
		public ModelAndView naverLogin(@RequestParam String code, @RequestParam String state, HttpSession session)
				throws Exception {
			ModelAndView mav = new ModelAndView();
			OAuth2AccessToken oauthToken;
			oauthToken = naverLoginDTO.getAccessToken(session, code, state);

			// �α����� ������� ��� ������ JSONŸ������ ����Ǿ� ����
			apiResult = naverLoginDTO.getUserProfile(oauthToken);

			// ���� ���ϴ� ���� (�̸�)�� JSONŸ�Կ��� StringŸ������ �ٲ� �������� ���� �۾�
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

			// �α���&�ƿ� �ϱ����� ���ǰ� �ֱ�
			session.setAttribute("nname", nname);
			session.setAttribute("nemail", nemail);
			session.setAttribute("ngender", ngender);
			session.setAttribute("nbirthday", nbirthday);
			session.setAttribute("nage", nage);
			session.setAttribute("nimage", nimage);
			session.setAttribute("nphone", nphone);

			// ���̹� �α��� ���� ������ View ȣ��
			mav.setViewName("main");
			return mav;
		}// end naverLogin()
	

	/**
	 * Authentication Code�� ���� �޴� ��������Ʈ
	 **/
	/*
	 * @GetMapping("/googleLogin") public String googleAuth(Model
	 * model, @RequestParam(value = "code") String authCode) throws Exception {
	 * 
	 * //HTTP Request�� ���� RestTemplate RestTemplate restTemplate = new
	 * RestTemplate();
	 * 
	 * //Google OAuth Access Token ��û�� ���� �Ķ���� ���� GoogleOAuthRequest
	 * googleOAuthRequestParam =
	 * GoogleOAuthRequest.builder().clientId(clientId).clientSecret(clientSecret).
	 * code(authCode).redirectUri("http://localhost:8080/member/googleLogin").
	 * grantType("authorization_code").build();
	 * 
	 * 
	 * //JSON �Ľ��� ���� �⺻�� ���� //��û�� �Ķ���ʹ� ������ũ ���̽��� ���õǹǷ� Object mapper�� �̸� �������ش�.
	 * ObjectMapper mapper = new ObjectMapper();
	 * mapper.setPropertyNamingStrategy(PropertyNamingStrategy.SNAKE_CASE);
	 * mapper.setSerializationInclusion(Include.NON_NULL);
	 * 
	 * logger.info("������� �����µ�");
	 * 
	 * //AccessToken �߱� ��û ResponseEntity<String> resultEntity =
	 * restTemplate.postForEntity(GOOGLE_TOKEN_BASE_URL, googleOAuthRequestParam,
	 * String.class);
	 * 
	 * 
	 * //Token Request GoogleOAuthResponse result =
	 * mapper.readValue(resultEntity.getBody(), new
	 * TypeReference<GoogleOAuthResponse>() { });
	 * 
	 * 
	 * //ID Token�� ���� (������� ������ jwt�� ���ڵ� �Ǿ��ִ�) String jwtToken =
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
//	 * ��ū ��ȿȭ 
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
		/* �׾Ʒ� ���� URL�� �����ϱ� ���Ͽ� getAuthorizationUrl�� ȣ�� */
		String naverAuthUrl = naverLoginDTO.getAuthorizationUrl(session);
		//String naverAuthUrl = naverLoginDTO.getAuthorizationUrl(session);
		String kakaoUrl = KakaoController.getAuthorizationUrl(session);

		/* ������ ���� URL�� View�� ���� */
		mav.setViewName("member/login");
		// ���̹� �α���
		mav.addObject("naver_url", naverAuthUrl);
		// īī�� �α���
		mav.addObject("kakao_url", kakaoUrl);
		
		return mav;
	}// end memberLoginForm()

	
	@RequestMapping(value = "terms1", method = RequestMethod.GET)
	public void terms1GET() {
		
		logger.info("��� ������ ����");
	}
	
	@RequestMapping(value = "terms2", method = RequestMethod.GET)
	public void terms2GET() {
		
		logger.info("��� ������ ����2");
	}

	// ���̵� ã�� ��
	@RequestMapping(value = "findId", method = RequestMethod.GET)
	public void findIdGET() {

		logger.info("id ã�� ������ ����");

	}

	// ��й�ȣ ã�� ��
	@RequestMapping(value = "findPw", method = RequestMethod.GET)
	public void findPwGET() {

		logger.info("��й�ȣ ã�� ������ ����");

	}

	@RequestMapping(value = "register", method = RequestMethod.GET)
	public void registerGET() {
		logger.info("ȸ������ �Ϸ�");
	}

	@RequestMapping(value = "test", method = RequestMethod.GET)
	public void testGET() {

		logger.info("�׽�Ʈ ������ ����");

	}

	// ȸ������
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String joinPOST(MemberVO member) throws Exception {

		String rawPw = ""; // ���ڵ� �� ��й�ȣ
		String encodePw = ""; // ���ڵ� �� ��й�ȣ

		rawPw = member.getUser_pw(); // ��й�ȣ ������ ����
		encodePw = encoder.encode(rawPw); // ��й�ȣ ���ڵ�
		member.setUser_pw(encodePw); // ���ڵ��� ��й�ȣ member��ü�� �ٽ� ����

		/* ȸ������ ���� ���� */
		mservice.memberJoin(member);

		return "redirect:/member/register";
	}

	// ���̵� �ߺ� �˻�
	@RequestMapping(value = "/memberIdChk", method = RequestMethod.POST)
	@ResponseBody
	public String memberIdChkPOST(String user_id) throws Exception {

		// logger.info("memberIdChk() ����");
		int result = mservice.idCheck(user_id);

		logger.info("����� = " + result);

		if (result != 0) {

			return "fail"; // �ߺ� ���̵� ����

		} else {

			return "success"; // �ߺ� ���̵� x

		}

	} // memberIdChkPOST() ����
	
	// ���� �̸��� �ߺ� �˻�
	@RequestMapping(value = "/memberEmailChk", method = RequestMethod.POST)
	@ResponseBody
	public String memberEmailChkPOST(String user_email) throws Exception {
		
		// logger.info("memberIdChk() ����");
		int result = mservice.emailCheck(user_email);
		
		logger.info("����� = " + result);
		
		if (result != 0) {
			
			return "fail"; // �ߺ� �̸����� ����
			
		} else {
			
			return "success"; // �ߺ� �̸����� x
			
		}
		
	} 

	// ���� �޴�����ȣ �ߺ� �˻�
	@RequestMapping(value = "/memberPhoneChk", method = RequestMethod.POST)
	@ResponseBody
	public String memberPhoneChkPOST(String user_phone) throws Exception {
		
		// logger.info("memberIdChk() ����");
		int result = mservice.phoneCheck(user_phone);
		
		logger.info("����� = " + result);
		
		if (result != 0) {
			
			return "fail"; // �ߺ� ��ȭ��ȣ�� ����
			
		} else {
			
			return "success"; // �ߺ� ��ȭ��ȣ�� x
			
		}
		
	} 
	
	/* �̸��� ���� */
	@RequestMapping(value = "/mailCheck", method = RequestMethod.GET)
	@ResponseBody
	public String mailCheckGET(String email) throws Exception {

		/* ��(View)�κ��� �Ѿ�� ������ Ȯ�� */
		logger.info("�̸��� ������ ���� Ȯ��");
		logger.info("������ȣ : " + email);

		/* ������ȣ(����) ���� */
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		logger.info("������ȣ " + checkNum);

		/* �̸��� ������ */
		String setFrom = "sa__s2@naver.com";
		String toMail = email;
		String title = "ȸ������ ���� �̸��� �Դϴ�.";
		String content = "PETCATION�� �湮���ּż� �����մϴ�." + "<br><br>" + "���� ��ȣ�� " + checkNum + "�Դϴ�." + "<br>"
				+ "�ش� ������ȣ�� ������ȣ Ȯ�ζ��� �����Ͽ� �ּ���.";

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

	/* �α��� */
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String loginPOST(HttpServletRequest request, MemberVO member, RedirectAttributes rttr) throws Exception {

		HttpSession session = request.getSession();
		String rawPw = "";
		String encodePw = "";

		MemberVO vo = mservice.memberLogin(member); // �����Ѿ��̵�� ��ġ�ϴ� ���̵� �ִ���

		if (vo != null) { // ��ġ�ϴ� ���̵� �����

			rawPw = member.getUser_pw(); // ����ڰ� ������ ��й�ȣ
			encodePw = vo.getUser_pw(); // �����ͺ��̽��� ������ ���ڵ��� ��й�ȣ

			if (true == encoder.matches(rawPw, encodePw)) { // ��й�ȣ ��ġ���� �Ǵ�

				vo.setUser_pw(""); // ���ڵ��� ��й�ȣ ���� ����
				session.setAttribute("lmember", vo); // session�� ������� ���� ����
			    // ���� �ð��� ���Ѵ�� ����
			    session.setMaxInactiveInterval(-1);
				return "redirect:/"; // ���������� �̵�

			} else {

				rttr.addFlashAttribute("result", 0);
				return "redirect:/member/login"; // �α��� �������� �̵�

			}

		} else { // ��ġ�ϴ� ���̵� �������� ���� �� (�α��� ����)

			rttr.addFlashAttribute("result", 0);
			return "redirect:/member/login"; // �α��� �������� �̵�

		}

	}

	/* �񵿱��� �α׾ƿ� �޼��� */
	@RequestMapping(value = "logout", method = RequestMethod.POST)
	@ResponseBody
	public void logoutPOST(HttpServletRequest request) throws Exception {

		logger.info("�񵿱� �α׾ƿ� �޼��� ����");

		HttpSession session = request.getSession();

		session.invalidate();
		
	}
	
	@RequestMapping(value="/searchPhone", method=RequestMethod.POST)
	public String searchPhonePost(MemberVO member, Model model) throws Exception {
		
		logger.info("���� �Ѱ�����?" + member.getUser_phone());
		String msg = "";
		
		//���� db�� ���̵�� �̸����� ��ġ�ϴ��� Ȯ���ϱ�
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
		  
		logger.info("���� �Ѱ�����?" + member.getUser_email());
		String pwd = "";
		
		//���� db�� ���̵�� �̸����� ��ġ�ϴ��� Ȯ���ϱ�
		MemberVO vo = mservice.searchEmail(member);

		if(vo != null) {
			//�ӽú�й�ȣ�� �߱��Ѵ�
			UUID uid = UUID.randomUUID();
			pwd = uid.toString().substring(0,10);

			String encPw = encoder.encode(pwd);
			vo.setUser_pw(encPw); //��ȣȭ ��Ų ��� ����
			mservice.updatePw(vo);


			String toMail = vo.getUser_email();
			String content = pwd;
			return "redirect:/member/pwdConfirmMail/"+toMail+"/"+content+"/"; 
		}
		
		else {
			return "redirect:/member/mailFail";
		}

	  }	  

		//��й�ȣ �нǽÿ� �ӽ� ��й�ȣ�� �߼��ϱ� ���� ���ϼ��� , GET���
		@RequestMapping(value="/pwdConfirmMail/{toMail}/{content}/", method=RequestMethod.GET)
		public String PwdConfirmMailFormGet(@PathVariable String toMail, @PathVariable String content) throws Exception {
			
			/* �̸��� ������ */
			String setFrom = "sa__s2@naver.com";
			String title = "��й�ȣ Ȯ�� �����Դϴ�.";
			String pwd = content;
			content = "PETCATION���� �߼۵� �����Դϴ�.\n�Ʒ� �ӽ� ��й�ȣ�� �������� ����Ʈ�� �����ϼż� ��й�ȣ�� �����ϼ���.\n";
			try {

				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(message, true,"UTF-8");

				//���� �����Կ� ����
				helper.setFrom(setFrom);
				helper.setTo(toMail);
				helper.setSubject(title);
				//messageHelper.setText(content);
				
				//�޼��� ����� �Բ� ������ ����
				content = content.replace("\n", "<br/>");
				content += "<font color=red>"+ pwd + "</font><br>";
				content += "<br><hr><h3>PECATION�Դϴ�.<h3><hr><br>";
//				content += "<p><img src=\"/resources/images/common/pa.png\" width='250px'></p><hr>";
				content += "<p>���õ� �ູ�� �ð��Ǽ���! </p>";
				helper.setText(content, true);
				//FileSystemResource file = new FileSystemResource(new File("C:/Users/Eunbi/Downloads/images/dog3.jpg"));
				//helper.addInline("dog3.jpg", file);
				
				//���ϰ� �Բ� ÷������ ����
//				FileSystemResource mfile = new FileSystemResource(new File("C:/Users/Eunbi/Downloads/images/dog2.jpg"));
//				messageHelper.addAttachment("1.jpg", mfile);
				
				//�޼��� ����� �Բ� ������ ����
				mailSender.send(message); //���� ���� ����
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
			// ������� node�� �����
			JsonNode node = KakaoController.getAccessToken(code);
			// accessToken�� ������� �α����� ��� ������ �������
			JsonNode accessToken = node.get("access_token");
			// ������� ����
			JsonNode userInfo = KakaoController.getKakaoUserInfo(accessToken);
			String kemail = null;
			String kname = null;
			String kgender = null;
			String kbirthday = null;
			String kage = null;
			String kimage = null;
			// �������� īī������ �������� Get properties
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
	  

	 