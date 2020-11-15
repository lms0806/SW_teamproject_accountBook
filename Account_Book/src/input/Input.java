package input;

public class Input {
	private String userID;
	private String category;
	private String Content;
	private int money;
	private String webDate;
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getContent() {
		return Content;
	}
	
	public void setContent(String content) {
		Content = content;
	}
	public int getMoney() {
		return money;
	}
	public void setMoney(int money) {
		this.money = money;
	}
	public String getWebDate() {
		return webDate;
	}
	public void setWebDate(String webDate) {
		this.webDate = webDate;
	}
}
