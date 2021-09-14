/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package myservets;

import com.google.gson.JsonObject;
import java.sql.ResultSet;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author Asus
 */
public class GetFlightNumbersTest {
    
    public GetFlightNumbersTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }

    /**
     * Test of ResultSet2JSONObject method, of class GetFlightNumbers.
     */
    @Test
    public void testResultSet2JSONObject() {
        System.out.println("ResultSet2JSONObject");
        ResultSet rs = null;
        JsonObject expResult = null;
        JsonObject result = GetFlightNumbers.ResultSet2JSONObject(rs);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }
    
}
