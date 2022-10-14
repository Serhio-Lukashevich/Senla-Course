public class WrappersJSON {
    public class InfoWrap {
        public Datetime createDate {get; set;}
        public Date rentStartDate {get; set;}
        public Date rentEndDate {get; set;}
        public Client client {get; set;}
        public Property property {get; set;}    

        public InfoWrap(Deal__c deal) {
            this.createDate = deal.CreatedDate;
            this.rentStartDate = deal.Start_Of_The_Lease__c;
            this.rentEndDate = deal.End_Of_The_Lease__c;
            this.client = new Client(deal.Buyer_Contact__r);
            this.property = new Property(deal.Property__r);
        }
    }

    public class Client {
        public String sfId {get; set;}
        public String firstName {get; set;}
        public String lastName {get; set;}
        public String email {get; set;}

        public Client(Contact buyer) {
            this.sfId = buyer.Id;
            this.firstName = buyer.FirstName;
            this.lastName = buyer.LastName;
            this.email = buyer.Email;
        }
    }

    public class Property {
        public String sfId {get; set;}
        public Client owner {get; set;}
        public LocationWrapper location {get; set;}

        public Property(Property__c property) {
            this.sfId = property.Id;
            this.owner = new Client(property.Property_Owner__r);
            this.location = new LocationWrapper(property);
        }
    }

    public class LocationWrapper {
        public String country {get; set;}
        public String city {get; set;}
        public String address {get; set;}
        public String latitude   {get; set;}
        public String longitude {get; set;}

        public LocationWrapper(Property__c property) {
            this.country = property.Country__c;
            this.city = property.City__c;
            this.address = property.Address__c;
        }
    }
    
     public class Response {
        public Date startDate {get; set;}
        public Date endDate {get; set;}
        public String totalRevenue {get; set;}
        public List<DealManager.DealWrapper> deals {get; set;}

        public Response (Date startDate, Date endDate, List<Deal__c> deals) {
            this.startDate = startDate;
            this.endDate = endDate;
            this.deals = new List<DealManager.DealWrapper>();
            Decimal revenue = 0;
            for (Deal__c deal : deals) {
                this.deals.add(new DealManager.DealWrapper(deal));
                if (deal.RecordType.DeveloperName == 'Lease') {
                    revenue += deal.Final_Amount__c;
                }
            }
            this.totalRevenue = String.valueOf(revenue);
        }
    }

    public class Client {
        public String sfId {get; set;}
        public String firstName {get; set;}
        public String lastName {get; set;}
        public String email {get; set;}

        public Client() {}
        public Client(Contact customer) {
            this.sfId = customer.Id;
            this.firstName = customer.FirstName;
            this.lastName = customer.LastName;
            this.email = customer.Email;
        }
    }

    public class UpdatePropertyOwnerPUTWrapper {
        public String propertyId {get; set;}
        public Client newOwner {get; set;}
    }
}