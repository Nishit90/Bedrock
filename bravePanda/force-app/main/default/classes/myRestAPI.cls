@RestResource(urlMapping='/salesforcekid/*')
global class myRestAPI {
    @HttpGet
    global static Product__c getProducts(){
    //create a new instance for product object
    Product__c prod = new Product__c();
    //As params returns in Map<string, string> format and request the params
    Map<string, string> paramsMap = RestContext.request.params;
    //It will get the Id passed from external system
    string prodId = paramsMap.get('Id');
    //Query the product record
    prod = [Select Id, Name, Product_Code__c From Product__c Where Id =: prodId];
    //delete prod;
    //return the product with that id
    return prod;
    }
    
    @HttpDelete
    global static String deleteProducts(){
    //create a new instance for product object
    Product__c prod = new Product__c();
    //As params returns in Map<string, string> format and request the params
    Map<string, string> paramsMap = RestContext.request.params;
    //It will get the Id passed from external system
    string prodId = paramsMap.get('Id');
    //Query the product record
    prod = [Select Id, Name, Product_Code__c From Product__c Where Id =: prodId];
    //Delete the product from salesforce
    Delete prod;
    //return the String 
    return 'Product Deleted';
    }
    
    @HttpPost
    //Name and ProductCode will come from external system as a input
    global static String createProducts(){
    //Create an instance of products
    /*Product__c prod = new Product__c();
    //Map the input params to name and productCode
    prod.Name = Name;
    prod.Product_Code__c = ProductCode;
    //insert the product
    insert prod;
    //Return this product to the third party system as a response
    return prod;  */
        RestRequest req = RestContext.request;
        System.debug('blob: '+req.requestBody);
        return req.requestBody.toString();
    }
    
    /* @HttpPost
    //Name and ProductCode will come from external system as a input
    global static Product__c createProducts( String Name, String ProductCode){
    //Create an instance of products
    Product__c prod = new Product__c();
    //Map the input params to name and productCode
    prod.Name = Name;
    prod.Product_Code__c = ProductCode;
    //insert the product
    insert prod;
    //Return this product to the third party system as a response
    return prod;  
    }*/
    
    @HttpPut
    //Name and ProductCode will come from external system as a input
    global static Product__c updateProducts( String Name, String ProductCode){
    //As params returns in Map<string, string> format and request the params
    Map<string, string> paramsMap = RestContext.request.params;
    //It will get the Id passed from external system
    string prodId = paramsMap.get('Id');
    //Create an instance of products
    Product__c prod = new Product__c();
    //Map the input params to Id, name and productCode 
    prod.Id = prodId;
    prod.Name = Name;
    prod.Product_Code__c = ProductCode;
    //insert the product
    update prod;
    //Return this product to the third party system as a response
    return prod;  
    }  
}