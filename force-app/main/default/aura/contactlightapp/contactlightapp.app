<aura:application >
    
    <link href='/resource/bootstrap/' rel="stylesheet" />
    
    <div class="navbar navbar-default navbar-static-top" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <a href="#" class="navbar-brand"> Lightning Contacts </a>         
            </div>       
        </div>    
    </div>
    
    <div class="container">
        <div class="row">
            <div> 
                <c.contactlight/> 
            </div>
            <div class="col-sm-12">
                <b> Contact List  </b>  
                <c:contactlight2/>
            </div>       
        </div>    
    </div>
    
</aura:application>