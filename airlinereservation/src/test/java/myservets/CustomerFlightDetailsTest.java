/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package myservets;

import com.google.gson.JsonObject;
import java.sql.ResultSet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

/**
 *
 * @author Asus
 */
public class CustomerFlightDetailsTest {
    
    public CustomerFlightDetailsTest() {
    }

    @BeforeClass
    public static void setUpClass() throws Exception {
    }

    @AfterClass
    public static void tearDownClass() throws Exception {
    }
    
    @BeforeEach
    public void setUp() {
    }
    
    @AfterEach
    public void tearDown() {
    }

    /**
     * Test of doGet method, of class CustomerFlightDetails.
     */
    @org.junit.Test
    public void testDoGet() throws Exception {
        System.out.println("doGet");
        HttpServletRequest request = null;
        HttpServletResponse response = null;
        CustomerFlightDetails instance = new CustomerFlightDetails();
        instance.doGet(request, response);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of ResultSet2JSONObject method, of class CustomerFlightDetails.
     */
    @org.junit.Test
    public void testResultSet2JSONObject() {
        System.out.println("ResultSet2JSONObject");
        ResultSet rs = null;
        JsonObject expResult = null;
        JsonObject result = CustomerFlightDetails.ResultSet2JSONObject(rs);
        assertEquals(expResult, result);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of doPost method, of class CustomerFlightDetails.
     */
    @org.junit.Test
    public void testDoPost() throws Exception {
        System.out.println("doPost");
        HttpServletRequest request = null;
        HttpServletResponse response = null;
        CustomerFlightDetails instance = new CustomerFlightDetails();
        instance.doPost(request, response);
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }
    
}
