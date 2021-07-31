({    
    init : function (cmp, event, helper) {
        const recordId = cmp.get('v.recordId'); 
        
        if (!recordId) {
            cmp.set('v.isIdNull', true);

            helper.getConstantRegistration(cmp).then(function(result) {
                window.location.assign(result);
            });
        }
    },
    
    updateData : function (cmp, event, helper) {
        helper.getTrips(cmp).then(function(result) {
            if (result.length) {
                let items = [];
                
                result.forEach(function(value) {
                    let item = { 
                        'label' : value.Name,
                        'value' : value.Id,
                        'Latitude' : value.Departure_Space_Point__r.Latitude__c, 
                        'Longitude' : value.Departure_Space_Point__r.Longitude__c
                    };
                    items.push(item);
                });
                
                cmp.set('v.trips', items);
                cmp.set('v.isTripSelected', true);
                cmp.set('v.selectedTripId', result[0].Id);
                
                const submitButton = cmp.find('submitButton');
                submitButton.set('v.variant', 'brand');
                submitButton.set('v.disabled', 'false');
                submitButton.set('v.title', $A.get('$Label.c.NoSeats'));
                
                const priceListButton = cmp.find('priceListButton');
                priceListButton.set('v.variant', 'brand');
                priceListButton.set('v.disabled', 'false');
                priceListButton.set('v.title', $A.get('$Label.c.NoSeats'));
                
                cmp.set('v.mapMarkers', [ {
                    location: {
                        Latitude : result[0].Departure_Space_Point__r.Latitude__c,
                        Longitude : result[0].Departure_Space_Point__r.Longitude__c
                    }
                }]);
                cmp.set('v.selectedTripId', result[0].Id);
                
                helper.createImagesList(cmp, cmp.get('v.selectedTripId'));
                
                cmp.set('v.showSpinner', false);
            } else {
                cmp.set('v.isTripSelected', false);
                cmp.set('v.showSpinner', false);
            }
        });
    },
    
    onChangeCombobox : function(cmp, event, helper) {
        let value = event.getParam('value');
        
        cmp.set('v.selectedTripId', value);
        cmp.set('v.isTripSelected', true);
        
        helper.createImagesList(cmp, value);
    },
    
    onClickSubmitButton : function (cmp, event, helper) {
        helper.createFlight(cmp).then(function(result) {
            if (result) {
                helper.showToast($A.get('$Label.c.Success'), $A.get('$Label.c.CreateComplete'));
                $A.get('e.force:refreshView').fire();
            } else {
                helper.showToast($A.get('$Label.c.Error'), $A.get('$Label.c.CreateFlightsError'));
            }
        });
    },
    
    onClickPriceListButton : function (cmp, event, helper) {
        helper.getConstantPriceList(cmp).then(function(result) {
            window.open(result + '?recordId=' + cmp.get('v.recordId'));
        });
    }
})