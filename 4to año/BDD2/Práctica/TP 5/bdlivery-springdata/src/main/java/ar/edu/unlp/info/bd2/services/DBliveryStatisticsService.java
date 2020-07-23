package ar.edu.unlp.info.bd2.services;

import java.util.Date;
import java.util.List;

import ar.edu.unlp.info.bd2.model.*;
import ar.edu.unlp.info.bd2.repositories.DBliveryException;

public interface DBliveryStatisticsService {


    /**
     * obtiene el producto más pesado
     * @return el producto más pesado
     */
    Product  getMaxWeigth();

    /**
     * Obtiene todas las ordenes realizadas por el usuario con username <code>username</code>
     * @param username
     * @return Una lista de ordenes que satisfagan la condición
     */
    List<Order> getAllOrdersMadeByUser(String username);

    /**
     * Obtiene el listado de las ordenes pendientes
     */
    List<Order> getPendingOrders();

    /**
     * Obtiene el listado de las ordenes enviadas y no entregadas
     */
    List<Order> getSentOrders();

    /**
     * Obtiene todas las ordenes entregadas entre dos fechas
     * @param startDate
     * @param endDate
     * @return una lista con las ordenes que satisfagan la condición
     */
    List<Order> getDeliveredOrdersInPeriod(Date startDate, Date endDate);

    /**
     * Obtiene todas las órdenes entregadas para el cliente con username <code>username</code>
     * @param username
     * @return una lista de ordenes que satisfagan la condición
     */
    List<Order> getDeliveredOrdersForUser(String username);

    /**
     * Obtiene los productos que no cambiaron su precio
     * @return una lista de productos que satisfagan la condición
     */
    List<Product> getProductsOnePrice();

    /**
     * obtiene los productos vendidos en un <code>day</code>
     * @param day
     * @return una lista los productos vendidos
     */
    List<Product> getSoldProductsOn(Date day);
}