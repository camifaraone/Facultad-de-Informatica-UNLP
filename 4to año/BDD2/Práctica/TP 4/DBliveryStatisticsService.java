package ar.edu.unlp.info.bd2.services;

import java.util.Date;
import java.util.List;

import ar.edu.unlp.info.bd2.model.*;
import ar.edu.unlp.info.bd2.repositories.DBliveryException;

public interface DBliveryStatisticsService {

    /**
     * Obtiene todas las ordenes realizadas por el usuario con username <code>username</code>
     * @param username
     * @return Una lista de ordenes que satisfagan la condición
     * @throws DBliveryException
     */
    List<Order> getAllOrdersMadeByUser(String username) throws DBliveryException;


    /**
     * Obtiene los <code>n</code> proveedores que más productos tienen en ordenes que están siendo enviadas
     * @param n
     * @return una lista con los <code>n</code> proveedores que satisfagan la condición
     */
    List<Supplier> getTopNSuppliersInSentOrders(int n);

    /**
     * Obtiene el listado de las ordenes pendientes
     */
    List <Order>  getPendingOrders();

    /**
     * Obtiene el listado de las ordenes enviadas y no entregadas
     */
    List <Order>  getSentOrders();


    /**
     * Obtiene todas las ordenes entregadas entre dos fechas
     * @param startDate
     * @param endDate
     * @return una lista con las ordenes que satisfagan la condición
     */
    List <Order> getDeliveredOrdersInPeriod(Date startDate, Date endDate);

    /**
     * Obtiene todas las órdenes entregadas para el cliente con username <code>username</code>
     * @param username
     * @return una lista de ordenes que satisfagan la condición
     */
    List <Order> getDeliveredOrdersForUser(String username);

    /**
     * Obtiene el producto con más demanda
     * @return el producto que satisfaga la condición
     */
    Product getBestSellingProduct();

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
    List <Product> getSoldProductsOn(Date day);

    /**
     * obtiene el producto más pesado
     * @return el producto más pesado
     */
    Product getMaxWeigth();

    /**
     * obtiene las ordenes que fueron realizadas a menos de 400 metros del centro de la plaza moreno.
     * Sus coordenadas son: [-34.921236,-57.954571]
     * @return la lista de ordenes que satisfagan la condición
     */
    List <Order> getOrderNearPlazaMoreno();
}