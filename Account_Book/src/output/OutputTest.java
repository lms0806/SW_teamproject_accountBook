package output;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class OutputTest {

	@Test
	void testGetOutputid() {
		Output output = new Output();
		output.setOutputid(4);
		assertEquals(4,output.getOutputid());
	}

	@Test
	void testGetUserID() {
		Output output = new Output();
		output.setUserID("lms0806");
		assertEquals("lms0806",output.getUserID());
	}

	@Test
	void testGetCategory() {
		Output output = new Output();
		output.setCategory("월급");
		assertEquals("월급",output.getCategory());
	}

	@Test
	void testGetContent() {
		Output output = new Output();
		output.setContent("11월 월급");
		assertEquals("11월 월급",output.getContent());
	}

	@Test
	void testGetMoney() {
		Output output = new Output();
		output.setMoney(10000);
		assertEquals(10000,output.getMoney());
	}

	@Test
	void testGetWebDate() {
		Output output = new Output();
		output.setWebDate("2020-12-06");
		assertEquals("2020-12-06",output.getWebDate());
	}

}
