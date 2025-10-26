@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'Z18FLIGHT'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_18FLIGHT
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_18FLIGHT
  association [1..1] to ZR_18FLIGHT as _BaseEntity on $projection.CARRIERID = _BaseEntity.CARRIERID and $projection.CONNECTIONID = _BaseEntity.CONNECTIONID and $projection.FLIGHTDATE = _BaseEntity.FLIGHTDATE
{
  key CarrierID,
  key ConnectionID,
  key FlightDate,
  @Semantics: {
    Amount.Currencycode: 'CurrencyCode'
  }
  Price,
  @Consumption: {
    Valuehelpdefinition: [ {
      Entity.Element: 'Currency', 
      Entity.Name: 'I_CurrencyStdVH', 
      Useforvalidation: true
    } ]
  }
  CurrencyCode,
  PlaneTypeID,
  @Semantics: {
    User.Createdby: true
  }
  LocalCreatedBy,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  LocalCreatedAt,
  @Semantics: {
    User.Localinstancelastchangedby: true
  }
  LocalLastChangedBy,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  LocalLastChangedAt,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  LastChangedAt,
  _BaseEntity
}
