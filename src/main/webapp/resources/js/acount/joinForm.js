/**
 * joinForm.jsp 유효성 검증하기
 */
$(function(){
	$("#join").validate({
		//규칙지정
		rules:{			
			//userid : 필수요소, 입력값 검증(영대소문자,숫자를 사용해서 5~12까지 허용)
			userId:{
				required:true,
				validId : true,
				remote:{ //$.ajax({})
					url : '/checkId',
					type : 'post',
					data:{
						userid : function(){
							return $("#userId").val();
						}
					}
				}
			},
			//password : 필수요소, 입력값 검증(영대소문자, 숫자, 특수문자 8~15까지 허용)
			userPw:{
				required:true,
				validPwd : true				
			},
			//confirm_password : password 검증규칙과 동일, password 입력값과 동일한지 검증
			confirm_password:{
				required:true,
				validPwd : true,				
				//equalTo: "#password"
			},
			//name : 필수요소, 2~4자리 허용
			userName:{
				required:true,
				rangelength:[2,4]
			},
			//gender : 필수요소
			nickName:{
				required:true,
			},
			//email: 필수요소, 이메일 검증
			email:{
				required:true,
				email:true
			}			
		},
		//규칙에 위배되는 경우 보여줄 메세지 작성
		messages:{
			userId:{
				required: "아이디는 반드시 기입해야합니다.",	
				remote : "이 아이디는 사용중입니다." //false, null, undefined
			},
			userPw:{
				required:"비밀번호는 반드시 기입해야합니다.",				
			},
			confirm_password:{
				required : "비밀번호를 확인해주세요.",
				equalTo : "비밀번호와 일치하는지 확인해주세요."
			},
			userName:{
				required : "이름은 반드시 기입해야합니다.",
				rangelength : "이름은 2~4자리로 입력해야 합니다."
			},
			nickName : "닉네임은 반드시 기입해야합니다."	
			email:{
				required : "이메일은 반드시 기입해야합니다."				
			},
		},
		//에러 보여주는 위치 지정
		errorPlacement:function(error,element){
			$(element).closest("form").find("small[id='"+element.attr("id")+"']").append(error);
		}
	});
});
$.validator.addMethod("validId", function(value) {
	var regId=/(?=.*^[A-Za-z])(?=.*\d)[A-Za-z\d]{5,12}/; //
	return regId.test(value);
}, '아이디는 영문자, 숫자를 사용하여 5~12자리까지 사용가능합니다.');
$.validator.addMethod("email", function(value) {
	var regEmail=/^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	return regEmail.test(value);
}, '이메일 형식이 다릅니다.');
$.validator.addMethod("validPwd", function(value) {
	var regPwd=/^(?=.*^[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{6,15}$/; 
	return regPwd.test(value);
}, '비밀번호는 문자,숫자,특수문자를 사용하여 6~15자리까지 사용가능합니다.');








