package fintech_pj_damn;

public class UserVo{
	private String Id;
	private String PassWord;
	private String UserName;
	private String Email;
	private String PhoneNum;
	private String Privilege;
	public String getId() {
		return Id;
	}
	public void setId(String Id) {
		this.Id = Id;
		
	}
	public String getPassWord() {
		return PassWord;
	}
	public void setPassWord(String PassWord) {
		this.PassWord = PassWord;
	}
	public String getUserName() {
		return UserName;
	}
	public void setUserName(String UserName) {
		this.UserName = UserName;
	}
	public String getEmail() {
		return Email;
	}
	public void setEmail(String Email) {
		this.Email = Email;
	}

	public String getPhoneNum() {
		return PhoneNum;
	}
	public void setPhoneNum(String PhoneNum) {
		this.PhoneNum = PhoneNum;
	}
	
	public String getPrivilege() {
		return Privilege;
	}
	public void setPrivilege(String Privilege) {
		this.Privilege = Privilege;
		
	}
	
	@Override
	public String toString() {
		return "UserVo [Id=" + Id + ", PassWord=" + PassWord + ", Email=" + Email
				+ "]";
	}
	
	
}