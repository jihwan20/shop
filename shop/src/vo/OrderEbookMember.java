package vo;

public class OrderEbookMember {
	// 조인에만 쓸 클래스
	private Order order;
	private Ebook ebook;
	private Member member;
	public Order getOrder() {
		return order;
	}
	public void setOrder(Order order) {
		this.order = order;
	}
	public Ebook getEbook() {
		return ebook;
	}
	public void setEbook(Ebook ebook) {
		this.ebook = ebook;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	@Override
	public String toString() {
		return "OrderEbookMember [order=" + order + ", ebook=" + ebook + ", member=" + member + "]";
	}
	// orderebookmember.toString()을 호출하는 테스트 작업
	public static void main(String[] args) {
		OrderEbookMember orderebookmember = new OrderEbookMember();
		System.out.println(orderebookmember);
	}
}
