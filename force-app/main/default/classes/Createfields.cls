/**
 * @description       :
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             :
 * @last modified on  : 01-25-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 **/
@RestResource(urlMapping='/Customfields')
global class Createfields {
  @HttpPost
  global static Map<String, String> GenerateCustomfields(
    String fieldType,
    String ObjectName,
    boolean Required,
    integer length,
    String label,
    String description,
    String inlineHelpText
  ) {
    Map<String, String> Resp = new Map<String, String>();
    HttpRequest request = new HttpRequest();
    request.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
    request.setHeader('Content-Type', 'application/json');
    request.setEndpoint(
      URL.getOrgDomainUrl().toExternalForm() +
      '/services/data/v56.0/tooling/sobjects/CustomField/'
    );
    request.setMethod('POST');
    if (fieldType == 'Text') {
      request.setBody(
        '{"Metadata" : {"type" : "' +
          fieldType +
          '","description" : "' +
          description +
          '", "inlineHelpText" : "' +
          inlineHelpText +
          '","label" : "' +
          label +
          '","length" : ' +
          length +
          ',"required" : ' +
          Required +
          '}, "FullName" : "' +
          ObjectName +
          '.' +
          label.replace(' ', '_') +
          '__c"}'
      );
    } else if (fieldType == 'Number') {
      request.setBody(
        '{"Metadata" : {"type" : "' +
          fieldType +
          '","description" : "' +
          description +
          '", "inlineHelpText" : "' +
          inlineHelpText +
          '","label" : "' +
          label +
          '","length" : ' +
          length +
          ',"required" : ' +
          Required +
          '}, "FullName" : "' +
          ObjectName +
          '.' +
          label.replace(' ', '_') +
          '__c"}'
      );
    } else {
      Resp.put('Error', 'Please provide field type');
      return Resp;
    }
    Http http = new Http();
    HTTPResponse res = http.send(request);
    if (res.getStatusCode() == 200 || res.getStatusCode() == 201) {
      Resp.put(
        'Success',
        'status: ' + res.getStatus() + ' Status Code: ' + res.getStatusCode()
      );
      Resp.put('StatusCode', '' + res.getStatusCode());
      Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(
        res.getBody()
      );
      Resp.put(
        'requestgetBody',
        URL.getOrgDomainUrl().toExternalForm() +
          '/lightning/setup/ObjectManager/' +
          ObjectName +
          '/FieldsAndRelationships/' +
          '' +
          m.get('id') +
          '/view'
      );
    } else {
      String body = res.getBody();
      Resp.put('Error', '' + res.getStatus());
      Resp.put('StatusCode', '' + res.getStatusCode());
      body = body.substring(1, body.length() - 1);
      map<String, object> m = (map<String, object>) JSON.deserializeUntyped(
        body
      );
      Resp.put('ErrorMessage', '' + m.get('message'));
      Resp.put('Endpoint', '' + request.getEndpoint());
    }
    return Resp;
  }
}
