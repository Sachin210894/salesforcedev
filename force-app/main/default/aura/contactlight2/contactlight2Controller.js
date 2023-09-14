({
    locationChange : function(component, event, helper) {
        
        var token = event.getParams("token");
        if(token.token!=null && token.token != ''){
        console.log('token==>',event.getParams("token"));
        console.log('token.token',token.token);
        var newtoken =    token.token; 
        console.log('token.token??',newtoken.slice(newtoken.indexOf('/') + 1));
   

           // console.log('token2', JSON.parse(token));
          if(newtoken != null && newtoken !='') {
            
            var contactId = newtoken.slice(newtoken.indexOf('/') + 1)
            console.log('contactid,',contactId);
              
            var action = component.get("c.findbyid");
            
            action.setParams({"contactId":contactId});
        }
            
            action.setCallback(this,function(a){
                component.set("v.contact",a.getReturnValue());
            });
            $A.enqueueAction(action);
        }
        
    }
})