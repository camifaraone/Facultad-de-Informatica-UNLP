package ar.edu.unlp.info.bd2.services;
import static org.junit.jupiter.api.Assertions.*;

import ar.edu.unlp.info.bd2.config.SpringDataConfiguration;
import ar.edu.unlp.info.bd2.model.*;
import ar.edu.unlp.info.bd2.repositories.DBliveryException;

import java.util.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.support.AnnotationConfigContextLoader;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Rollback(true)
@ExtendWith(SpringExtension.class)
@ContextConfiguration(
        classes = {SpringDataConfiguration.class},
        loader = AnnotationConfigContextLoader.class)
public class DBliveryServiceTestCase {

    @Autowired
    @Qualifier("springDataJpaService")
    DBliveryService service;

    protected DBliveryService getService() {
        return service;
    }

    @BeforeEach
    public void setUp() {
        this.service = this.getService();
    }

    @Test
    public void testCreateUser() {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.YEAR, 1982);
        cal.set(Calendar.MONTH, Calendar.MAY);
        cal.set(Calendar.DAY_OF_MONTH, 17);
        Date dob = cal.getTime();
        User u1 = this.service.createUser("hugo.gamarra@testmail.com", "123456", "hgamarra", "Hugo Gamarra", dob);
        assertNotNull(u1.getId());
    }

    @Test
    public void testGetUser() {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.YEAR, 1982);
        cal.set(Calendar.MONTH, Calendar.MAY);
        cal.set(Calendar.DAY_OF_MONTH, 17);
        Date dob = cal.getTime();
        User u1 = this.service.createUser("hugo.gamarra@testmail.com", "123456", "hgamarra", "Hugo Gamarra", dob);
        assertNotNull(u1.getId());
        assertEquals("hgamarra", u1.getUsername());
        Optional<User> u2 = this.service.getUserByUsername("hgamarra");
        if (u2.isPresent()) {
            User u3 = u2.get();
            assertEquals("hgamarra", u3.getUsername());
            assertEquals("hugo.gamarra@testmail.com", u3.getEmail());
        }
        Optional<User> u4 = this.service.getUserByEmail("hugo.gamarra@testmail.com");
        if (u4.isPresent()) {
            User u5 = u4.get();
            assertEquals("hgamarra", u5.getUsername());
            assertEquals("hugo.gamarra@testmail.com", u5.getEmail());
        }
        Optional<User> u6= this.service.getUserById(u1.getId());
        if (u6.isPresent()) {
            User u7 = u6.get();
            assertEquals("hgamarra", u7.getUsername());
            assertEquals("hugo.gamarra@testmail.com", u7.getEmail());
            assertEquals(u7.getId(), u1.getId());
        }
    }

    @Test
    public void testCreateProduct() {
        Supplier s1 = this.service.createSupplier("Burger King", "30710256443", "Av. Corrientes 956", Float.valueOf(-53.45F), Float.valueOf(-60.22F));
        assertNotNull(s1.getId());
        assertEquals("Burger King",s1.getName());
        Product p1 = this.service.createProduct("Combo Stacker ATR", Float.valueOf(2521.2F), Float.valueOf(2.5F),s1);
        assertNotNull(p1.getId());
        assertEquals("Combo Stacker ATR",p1.getName());
        assertEquals(1,p1.getPrices().size());
    }

    @Test
    public void testUpdateProductPrice() throws DBliveryException{
        Calendar cal = Calendar.getInstance();
        Date startDate = cal.getTime();
        Supplier s1 = this.service.createSupplier("Burger King", "30710256443", "Av. Corrientes 956", Float.valueOf(-53.45F), Float.valueOf(-60.22F));
        Product p1 = this.service.createProduct("Combo Stacker ATR", Float.valueOf(2521.2F), Float.valueOf(2.5F),s1);
        assertNotNull(p1.getId());
        assertEquals(1,p1.getPrices().size());
        Product p2 = this.service.updateProductPrice(p1.getId(),Float.valueOf(3000.0F),startDate);
        assertEquals(Float.valueOf(3000.0F),p2.getPrice());
        assertEquals(2,p2.getPrices().size());
    }

    @Test
    public void testCreateOrder() throws DBliveryException {
        Calendar cal = Calendar.getInstance();
        Date orderDate = cal.getTime();
        Supplier s1 = this.service.createSupplier("Burger King", "30710256443", "Av. Corrientes 956", Float.valueOf(-53.45F), Float.valueOf(-60.22F));
        Product p1 = this.service.createProduct("Combo Stacker ATR", Float.valueOf(2521.2F), Float.valueOf(2.5F),s1);
        Calendar cal2 = Calendar.getInstance();
        cal2.set(Calendar.YEAR, 1982);
        cal2.set(Calendar.MONTH, Calendar.MAY);
        cal2.set(Calendar.DAY_OF_MONTH, 17);
        Date dob = cal.getTime();
        User u1 = this.service.createUser("hugo.gamarra@testmail.com", "123456", "hgamarra", "Hugo Gamarra", dob);
        Order o1 = this.service.createOrder(orderDate,"Av. Corrientes 1405 2° B", Float.valueOf(-54.45F), Float.valueOf(-62.22F),u1);
        Order o2 = this.service.addProduct(o1.getId(), 1L, p1);
        assertNotNull(o1.getId());
        assertNotNull(o2.getId());
        assertEquals(1,o2.getStatus().size());
        assertEquals(u1,o2.getClient());
        assertEquals(1,o2.getProducts().size());
    }

    @Test
    public void testDeliverOrder() throws DBliveryException {
        Calendar cal = Calendar.getInstance();
        Date orderDate = cal.getTime();
        Supplier s1 = this.service.createSupplier("Burger King", "30710256443", "Av. Corrientes 956", Float.valueOf(-53.45F), Float.valueOf(-60.22F));
        Product p1 = this.service.createProduct("Combo Stacker ATR", Float.valueOf(2521.2F), Float.valueOf(2.5F),s1);
        Calendar cal2 = Calendar.getInstance();
        cal2.set(Calendar.YEAR, 1982);
        cal2.set(Calendar.MONTH, Calendar.MAY);
        cal2.set(Calendar.DAY_OF_MONTH, 17);
        Date dob = cal.getTime();
        User u1 = this.service.createUser("hugo.gamarra@testmail.com", "123456", "hgamarra", "Hugo Gamarra", dob);
        cal2.set(Calendar.YEAR, 1988);
        cal2.set(Calendar.MONTH, Calendar.JUNE);
        cal2.set(Calendar.DAY_OF_MONTH, 23);
        Date dob2 = cal.getTime();
        User u2 = this.service.createUser("delivery@info.unlp.edu.ar", "123456", "delivery", "Delivery", dob2);
        Order o1 = this.service.createOrder(orderDate,"Av. Corrientes 1405 2° B", Float.valueOf(-54.45F), Float.valueOf(-62.22F),u1);
        assertFalse(this.service.canDeliver(o1.getId()));
        assertThrows(DBliveryException.class, () -> this.service.deliverOrder(o1.getId(),u2),"The order can't be delivered");
        Order o2 = this.service.addProduct(o1.getId(), 1L, p1);
        assertTrue(this.service.canDeliver(o2.getId()));
        Order o3 = this.service.deliverOrder(o2.getId(),u2);
        assertNotNull(o3.getId());
        assertEquals(2,o3.getStatus().size());
        assertEquals(u2,o3.getDeliveryUser());
    }

    @Test
    public void testCancelOrder() throws Exception {
        Calendar cal = Calendar.getInstance();
        Date orderDate = cal.getTime();
        Calendar cal2 = Calendar.getInstance();
        cal2.set(Calendar.YEAR, 1982);
        cal2.set(Calendar.MONTH, Calendar.MAY);
        cal2.set(Calendar.DAY_OF_MONTH, 17);
        Date dob = cal.getTime();
        User u1 = this.service.createUser("hugo.gamarra@testmail.com", "123456", "hgamarra", "Hugo Gamarra", dob);
        Supplier s1 = this.service.createSupplier("Burger King", "30710256443", "Av. Corrientes 956", Float.valueOf(-53.45F), Float.valueOf(-60.22F));
        Order o1 = this.service.createOrder(orderDate,"Av. Corrientes 1405 2° B", Float.valueOf(-54.45F), Float.valueOf(-62.22F),u1);
        assertTrue(this.service.canCancel(o1.getId()));
        cal2.set(Calendar.YEAR, 1988);
        cal2.set(Calendar.MONTH, Calendar.JUNE);
        cal2.set(Calendar.DAY_OF_MONTH, 23);
        Date dob2 = cal.getTime();
        User u2 = this.service.createUser("delivery@info.unlp.edu.ar", "123456", "delivery", "Delivery", dob2);
        Product p1 = this.service.createProduct("Combo Stacker ATR", Float.valueOf(2521.2F), Float.valueOf(2.5F),s1);
        Order o2 = this.service.addProduct(o1.getId(), 1L, p1);
        Order o3 = this.service.deliverOrder(o2.getId(), u2);
        assertFalse(this.service.canCancel(o3.getId()));
        assertThrows(DBliveryException.class, () -> this.service.cancelOrder(o3.getId()),"The order can't be cancelled");
        Order o4 = this.service.createOrder(orderDate,"Av. Corrientes 1405 2° B", Float.valueOf(-54.45F), Float.valueOf(-62.22F),u1);
        Order o5 = this.service.cancelOrder(o4.getId());
        assertEquals(this.service.getActualStatus(o5.getId()).getStatus(),"Cancelled");
        assertEquals(2,o5.getStatus().size());
    }

    @Test
    public void testFinishOrder() throws DBliveryException {
        Calendar cal = Calendar.getInstance();
        Date orderDate = cal.getTime();
        Supplier s1 = this.service.createSupplier("Burger King", "30710256443", "Av. Corrientes 956", Float.valueOf(-53.45F), Float.valueOf(-60.22F));
        Product p1 = this.service.createProduct("Combo Stacker ATR", Float.valueOf(2521.2F), Float.valueOf(2.5F),s1);
        Calendar cal2 = Calendar.getInstance();
        cal2.set(Calendar.YEAR, 1982);
        cal2.set(Calendar.MONTH, Calendar.MAY);
        cal2.set(Calendar.DAY_OF_MONTH, 17);
        Date dob = cal.getTime();
        User u1 = this.service.createUser("hugo.gamarra@testmail.com", "123456", "hgamarra", "Hugo Gamarra", dob);
        cal2.set(Calendar.YEAR, 1988);
        cal2.set(Calendar.MONTH, Calendar.JUNE);
        cal2.set(Calendar.DAY_OF_MONTH, 23);
        Date dob2 = cal.getTime();
        User u2 = this.service.createUser("delivery@info.unlp.edu.ar", "123456", "delivery", "Delivery", dob2);
        Order o1 = this.service.createOrder(orderDate,"Av. Corrientes 1405 2° B", Float.valueOf(-54.45F), Float.valueOf(-62.22F),u1);
        Order o2 = this.service.addProduct(o1.getId(), 1L, p1);
        assertThrows(DBliveryException.class, () -> this.service.finishOrder(o2.getId()),"The order can't be finished");
        Order o3 = this.service.deliverOrder(o2.getId(),u2);
        assertTrue(this.service.canFinish(o3.getId()));
        Order o4 = this.service.finishOrder(o3.getId());
        assertNotNull(o4.getId());
        assertEquals(3,o3.getStatus().size());
        assertEquals(this.service.getActualStatus(o4.getId()).getStatus(),"Delivered");
    }

    @Test
    public void testGetProduct() {
        Supplier s1 = this.service.createSupplier("Burger King", "30710256443", "Av. Corrientes 956", Float.valueOf(-53.45F), Float.valueOf(-60.22F));
        assertNotNull(s1.getId());
        assertEquals("Burger King",s1.getName());
        Product p1 = this.service.createProduct("Combo Stacker ATR", Float.valueOf(2521.2F), Float.valueOf(2.5F),s1);
        Product p2 = this.service.createProduct("Combo Tostado de Campo", Float.valueOf(2210.2F), Float.valueOf(2.2F), s1);
        Product p3 = this.service.createProduct("Combo Stacker ATR triple", Float.valueOf(1210F), Float.valueOf(1.8F), s1);
        assertEquals(this.service.getProductsByName("Combo Stacker ATR").size(),2);
        assertEquals(this.service.getProductsByName("Combo Tostado de Campo").size(),1);
        assertEquals(this.service.getProductsByName("triple").size(),1);

    }
}
