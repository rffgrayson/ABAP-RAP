CLASS LHC_ZR_18FLIGHT DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR Flight
        RESULT result,
      validatePrice FOR VALIDATE ON SAVE
            IMPORTING keys FOR Flight~validatePrice,
      validateCurrencyCode FOR VALIDATE ON SAVE
            IMPORTING keys FOR Flight~validateCurrencyCode.
ENDCLASS.

CLASS LHC_ZR_18FLIGHT IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
  METHOD validatePrice.

    DATA failed_record LIKE LINE OF failed-flight.
    DATA reported_record LIKE LINE OF reported-flight.

    READ ENTITIES OF zr_18flight IN LOCAL MODE
        ENTITY Flight
        FIELDS ( price )
        WITH CORRESPONDING #( keys )
        RESULT DATA(flights).

    LOOP AT flights INTO DATA(flight).
        IF flight-price <= 0.

            failed_record-%tky = flight-%tky.
            APPEND failed_record TO failed-flight.

            reported_record-%tky = flight-%tky.

            reported_record-%msg =
            new_message(
                id = 'LRN/S4D400'
                number = '101'
                severity = if_abap_behv_message=>severity-error
            ).
            APPEND reported_record TO reported-flight.

        ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD validateCurrencyCode.

    DATA failed_record LIKE LINE OF failed-flight.
    DATA reported_record LIKE LINE OF reported-flight.

    DATA exists TYPE abap_bool.

    READ ENTITIES OF zr_18flight IN LOCAL MODE
        ENTITY Flight
        FIELDS ( currencycode )
        WITH CORRESPONDING #( keys )
        RESULT DATA(flights).

    LOOP AT flights INTO DATA(flight).
        exists = abap_false.
        SELECT SINGLE FROM i_currency
            FIELDS @abap_true
            WHERE currency = @flight-currencycode
            INTO @exists.

        IF exists = abap_false.
            failed_record-%tky = flight-%tky.
            APPEND failed_record TO failed-flight.

            reported_record-%tky = flight-%tky.

            reported_record-%msg =
            new_message(
                id = 'LRN/S4D400'
                number = '102'
                v1 = flight-currencycode
                severity = if_abap_behv_message=>severity-error
            ).
            APPEND reported_record TO reported-flight.
        ENDIF.

    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
