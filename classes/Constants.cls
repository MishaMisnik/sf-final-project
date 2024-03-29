public class Constants {
    public static final String WEATHERBIT_URL = 'https://api.weatherbit.io/v2.0/forecast/daily';
    public static final String WEATHERBIT_KEY = '8a76d367d14a4143990895fd7281e9f8';
    public static final String HTTP_METHOD_GET = 'GET'; 
    
    public static final String FOUND_DUPLICATE = 'Found duplicate';
    public static final String INTERNAL_ERROR = 'Internal server error';
    
    public static final Integer ERROR_404 = 404;
    public static final Integer OK_200 = 200;
    public static final Integer CONFLICT_409 = 409;
    public static final Integer CONFLICT_400 = 400;
    public static final Integer INTERNAL_ERROR_500 = 500;
    
    public static final String COMMUNITY_URL = URL.getSalesforceBaseUrl().toExternalForm() + '/TouristAssignment/s/';
    public static final String COMMUNITY_TOURIST_ASSIGNMENT_URL = URL.getSalesforceBaseUrl().toExternalForm() + '/TouristAssignment/s/tourist-assignment';
    public static final String COMMUNITY_TOURIST_REGISTRATION_URL = URL.getSalesforceBaseUrl().toExternalForm() + '/TouristAssignment/s/tourist-registration';
    public static final String COMMUNITY_TOURIST_PRICELIST_URL = URL.getSalesforceBaseUrl().toExternalForm() + '/TouristAssignment/s/price-list';
    
    public static final String TRIP_PRICE_BOOK = 'Trips';
    
    public static final Integer STANDARD_PRICE_FOR_TRIP = 500;
    public static final Integer CUSTOM_PRICE_FOR_TRIP = 300;
}