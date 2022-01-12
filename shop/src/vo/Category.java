package vo;

public class Category {
	private String categoryName;
	private String updateDate;
	private String createDate;
	private String categoryState;
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getCategoryState() {
		return categoryState;
	}
	public void setCategoryState(String categoryState) {
		this.categoryState = categoryState;
	}
	@Override
	public String toString() {
		return "Category [categoryName=" + categoryName + ", updateDate=" + updateDate + ", createDate=" + createDate
				+ ", categoryState=" + categoryState + "]";
	}
	// category.toString()을 호출하는 테스트 작업
	public static void main(String[] args) {
		Category category = new Category();
		System.out.println(category);
	}
}
