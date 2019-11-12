/**
 * changePwd.jsp 유효성 검증하기
 */
$(function(){
	$("#update").validate({
		//규칙지정
		rules:{			
			//password : 필수요소, 입력값 검증(영대소문자, 숫자, 특수문자 6~15까지 허용)
			new_password:{
				required:true,
				validPwd : true				
			},
			//confirm_password : password 검증규칙과 동일, password 입력값과 동일한지 검증
			confirm_password:{
				required:true,
				validPwd : true,				
				equalTo: "#new_password"
			},
			nickName:{
				rangelength: [2,15],
				remote:{ //$.ajax({})
					url : '/checkNickName',
					type : 'post',
					data:{
						nickName : function(){
							return $("#nickName").val();
						}
					}
				}
			},
			email:{
				email: true					
			}
		},
		//규칙에 위배되는 경우 보여줄 메세지 작성
		messages:{			
			new_password:{
				required:"새 비밀번호를 입력해주세요",				
			},
			confirm_password:{
				required : "새 비밀번호를 확인해주세요",
				equalTo : "새 비밀번호와 동일하게 입력해주세요"
			},
			//confirm_password : password 검증규칙과 동일, password 입력값과 동일한지 검증
			nickName:{
				rangelength : "닉네임은 2~15자리로 입력해야 합니다.",
				remote : "이 닉네임는 사용중입니다." //false, null, undefined
			},
			//confirm_password : password 검증규칙과 동일, password 입력값과 동일한지 검증
			email:{
			}
		},
		//에러 보여주는 위치 지정
		errorPlacement:function(error,element){
			$(element).closest("form").find("small[id='"+element.attr("id")+"']").append(error);
		}
	});
});
$.validator.addMethod("validPwd", function(value) {
	var regPwd=/(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{6,15}$/;
	return regPwd.test(value);
}, '비밀번호는 영문자,숫자,특수문자를 사용하여 6~15자리까지 사용가능합니다.');

$.validator.addMethod("email", function(value) {
	var regEmail=/^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	return regEmail.test(value);
}, '이메일 형식이 다릅니다.');







