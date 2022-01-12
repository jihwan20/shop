package vo;

public class Order {
	private int orderNo;
	private int ebookNo;
	private int memberNo;
	private int orderPrice;
	private String createDate;
	private String updateDate;
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	public int getEbookNo() {
		return ebookNo;
	}
	public void setEbookNo(int ebookNo) {
		this.ebookNo = ebookNo;
	}
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	public int getOrderPrice() {
		return orderPrice;
	}
	public void setOrderPrice(int orderPrice) {
		this.orderPrice = orderPrice;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	@Override
	public String toString() {
		return "Order [orderNo=" + orderNo + ", ebookNo=" + ebookNo + ", memberNo=" + memberNo + ", orderPrice="
				+ orderPrice + ", createDate=" + createDate + ", updateDate=" + updateDate + "]";
	}
	// order.toString()을 호출하는 테스트 작업
	public static void main(String[] args) {
		Order order = new Order();
		System.out.println(order);
	}
}
