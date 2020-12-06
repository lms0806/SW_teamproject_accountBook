package input;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class InputTest {

	@Test
	void testGetInputid() {
		Input input = new Input();
		input.setInputid(4);
		assertEquals(4,input.getInputid());
	}

	@Test
	void testGetUserID() {
		Input input = new Input();
		input.setUserID("lms0806");
		assertEquals("lms0806",input.getUserID());
	}

	@Test
	void testGetCategory() {
		Input input = new Input();
		input.setCategory("월급");
		assertEquals("월급",input.getCategory());
	}

	@Test
	void testGetContent() {
		Input input = new Input();
		input.setContent("11월 월급");
		assertEquals("11월 월급",input.getContent());
	}

	@Test
	void testGetMoney() {
		Input input = new Input();
		input.setMoney(10000);
		assertEquals(10000,input.getMoney());
	}

	@Test
	void testGetWebDate() {
		Input input = new Input();
		input.setWebDate("2020-12-06");
		assertEquals("2020-12-06",input.getWebDate());
	}

}
