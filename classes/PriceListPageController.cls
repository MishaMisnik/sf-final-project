public inherited sharing class PriceListPageController {
    public List<Trip__c> trips { get; set; }
    public Tourist__c tourist { get; set; }
    
    public PriceListPageController() {
        Id recordId = System.currentPagereference().getParameters().get('Id');
        
        if (recordId != null) {
            this.tourist = TouristManager.getByid(ApexPages.currentPage().getParameters().get('Id'));
            this.trips = TripServise.getPriceFromPriceBook(TripManager.getByTouristParams(tourist));
        }
    }
}