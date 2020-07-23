package ar.edu.unlp.info.bd2.services;
import ar.edu.unlp.info.bd2.model.*;
import ar.edu.unlp.info.bd2.repositories.DBliveryException;


import java.util.Date;
import java.util.List;
import java.util.Optional;


public interface DBliveryService {

	/**
	 *  Crea y devuelve un nuevo Producto.
	 * @param name nombre del producto a ser creado
	 * @param price precio actual del producto
	 * @param weight peso actual del producto
	 * @param supplier el productor del producto
	 * @return el producto creado
	 */
	Product createProduct(String name, Float price, Float weight, Supplier supplier);
	Product createProduct(String name, Float price, Float weight, Supplier supplier, Date date);

	/**
	 * Crea y retorna un nuevo Productor
	 * @param name nombre del productor
	 * @param cuil cuil del productor
	 * @param address dirección del productor
	 * @param coordX  coordenada X de la dirección del productor
	 * @param coordY coordeada Y de la dirección del produtor
	 * @return el productor creado
	 */
	Supplier createSupplier(String name, String cuil, String address, Float coordX, Float coordY);

	/**
	 * Crea y retorna un Usuario
	 * @param email email del usuario
	 * @param password clave del usuario
	 * @param username nombre de usuario del usuario
	 * @param name nombre y apellido del usuario
	 * @param dateOfBirth fecha de nacimiento del usuario
	 * @return el usuario creado
	 */
	User createUser(String email, String password, String username, String name, Date dateOfBirth);

	/**
	 * Actualiza el precio del producto manteniendo el historial de cambios de precio del mismo.
	 * @param id id del producto
	 * @param price nuevo precio del producto
	 * @param startDate fecha de inicio del nuevo precio
	 * @return el producto modificado
	 * @throws DBliveryException en caso de que no exista el producto para el id dado
	 */
	Product updateProductPrice(Long id, Float price, Date startDate) throws DBliveryException;

	/**
	 * Obtiene el usuario por id
	 * @param id
	 * @return el usuario con el id provisto
	 */
	Optional<User> getUserById(Long id);

	/**
	 * Obtiene el usuario por el email
	 * @param email
	 * @return el usuario con el email provisto
	 */
	Optional<User> getUserByEmail(String email);

	/**
	 * Obtiene el usuario por el username
	 * @param username
	 * @return el usuario con el username provisto
	 */
	Optional<User> getUserByUsername(String username);


	/**
	 * Obtiene el pedido por id
	 * @param id
	 * @return el pedido con el id provisto
	 */
	Optional<Order> getOrderById(Long id);

	/**
	 * Crea y retorna un nuevo pedido
	 * @param dateOfOrder timestamp de la fecha en que fue realizado el pedido
	 * @param address dirección en la cual se debe entregar el pedido
	 * @param coordX coordenada X de la dirección
	 * @param coordY coordenada Y de la dirección
	 * @param client cliente que realizó el pedido
	 * @return el nuevo pedido
	 */
	Order createOrder(Date dateOfOrder, String address, Float coordX, Float coordY,User client);

	/**
	 * agrega un producto al pedido
	 * @param order pedido al cual se le agrega el producto
	 * @param quantity cantidad de producto a agregar
	 * @param product producto a agregar
	 * @return el pedido con el nuevo producto
	 * @throws DBliveryException en caso de no existir el pedido
	 */
	Order addProduct (Long order,Long quantity, Product product )throws DBliveryException;

	/**
	 * Registra el envío del pedido, registrando al repartidor y cambiando su estado a Send.
	 * @param order pedido a ser enviado
	 * @param deliveryUser Usuario que entrega el pedido
	 * @return el pedido modificado
	 * @throws DBliveryException en caso de no existir el pedido, que el pedido no se encuentre en estado Pending o sí no contiene productos.
	 */
	Order deliverOrder(Long order, User deliveryUser) throws DBliveryException;
	Order deliverOrder(Long order, User deliveryUser, Date date) throws DBliveryException;

	/**
	 * Cancela un pedido
	 * @param order id del pedido a cancelar
	 * @return el pedido modificado
	 * @throws DBliveryException en caso de no existir el pedido o si el pedido no esta en estado pending
	 */
	Order cancelOrder(Long order) throws DBliveryException;
	Order cancelOrder(Long order, Date date) throws DBliveryException;

	/**
	 * Registra la entrega de un pedido.
	 * @param order pedido a finalizar
	 * @return el pedido modificado
	 * @throws DBliveryException en caso que no exista el pedido o si el mismo no esta en estado Send
	 */
	Order finishOrder(Long order) throws DBliveryException;
	Order finishOrder(Long order, Date date) throws DBliveryException;

	/**
	 * verifica si un pedido se puede cancelar, para lo cual debe estar en estado pending
	 * @param order pedido a ser cancelado
	 * @return true en caso que pueda ser cancelado false en caso contrario.
	 * @throws DBliveryException si no existe el pedido.
	 */
	boolean canCancel(Long order) throws DBliveryException;

	/**
	 * verifica si se puede finalizar un pedido
	 * @param id del pedido a finalizar
	 * @return true en caso que pueda ser finalizado, false en caso contrario
	 * @throws DBliveryException en caso de no existir el pedido
	 */
	boolean canFinish(Long id) throws DBliveryException;

	/**
	 * verifica si un pedido puede ser enviado para lo cual debe tener productos y estar en estado pending
	 * @param order pedido a ser enviado
	 * @return true en caso que pueda ser enviado, false en caso contrario
	 * @throws DBliveryException si el pedido no esta en estado pending.
	 */
	boolean canDeliver(Long order) throws DBliveryException;

	/**
	 * Obtiene el estado actual de un pedido.
	 * @param order pedido del cual se debe retornar el estado actual
	 * @return el estado del pedido actual
	 */
	OrderStatus getActualStatus(Long order);

	/**
	 * Obtiene el listado de productos que su nombre contega el string dado
	 * @param name string a buscar
	 * @return Lista de productos
	 */
	List<Product> getProductsByName(String name);

}
