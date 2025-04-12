CLASS zcl_tpv_abap_course_basics DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_abap_course_basics.
    INTERFACES if_oo_adt_classrun.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_tpv_abap_course_basics IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " TODO: variable is assigned but only used in commented-out code (ABAP cleaner)
    DATA(result_task_1) = zif_abap_course_basics~hello_world( 'Tsvetan' ).
*    out->write( result_task_1 ).

    " TODO: variable is assigned but only used in commented-out code (ABAP cleaner)
    DATA(result_task_2) = zif_abap_course_basics~calculator( iv_first_number  = 2
                                                                 iv_second_number = 0
                                                                 iv_operator      = '/' ).
*    out->write( result_task_2 ).

    " TODO: variable is assigned but only used in commented-out code (ABAP cleaner)
    DATA(result_task_3) = zif_abap_course_basics~fizz_buzz( ).
*    out->write( result_task_3 ).

    DATA(result_task_4) = zif_abap_course_basics~date_parsing( '4 5 2015' ).
   " out->write(  result_task_4  ).

    DATA(result_task_5) = zif_abap_course_basics~scrabble_score( 'YoYo' ).
*    out->write(  result_task_5  ).

    DATA(result_task_6) = zif_abap_course_basics~get_current_date_time( ).
    out->write(  result_task_6  ).

*    DATA(result) = me->zif_abap_course_basics~get_current_date_time(  ).
*     DATA(date) = me->zif_abap_course_basics~get_current_date_time(  ).
*    out->write( date ).
  ENDMETHOD.


  METHOD zif_abap_course_basics~calculator.
    DATA lv_message TYPE string.

    IF iv_operator = '+'.
      rv_result = iv_first_number + iv_second_number.
    ELSEIF iv_operator = '-'.
      rv_result = iv_first_number - iv_second_number.
    ELSEIF iv_operator = '*'.
      rv_result = iv_first_number * iv_second_number.
    ELSEIF iv_operator = '/'.
      TRY.
          rv_result = iv_first_number / iv_second_number.
        CATCH  cx_sy_zerodivide.
          lv_message = 'Error: Division by zero is not allowed'.
      ENDTRY.
    ELSE.
      lv_message = ' Wrong operator!'.

    ENDIF.


  ENDMETHOD.

  METHOD zif_abap_course_basics~date_parsing.
    DATA day     TYPE string.
    DATA month   TYPE string.
    DATA year    TYPE string.
    DATA counter TYPE i VALUE 1.
    DATA element TYPE string.

    SPLIT iv_date AT space INTO day month year.

    IF NOT month CO '0123456789'.

      DATA months TYPE TABLE OF string.
      APPEND 'January' TO months.
      APPEND 'February' TO months.
      APPEND 'March' TO months.
      APPEND 'April' TO months.
      APPEND 'May' TO months.
      APPEND 'June' TO months.
      APPEND 'July' TO months.
      APPEND 'August' TO months.
      APPEND 'September' TO months.
      APPEND 'October' TO months.
      APPEND 'November' TO months.
      APPEND 'December' TO months.

      LOOP AT months INTO element.
        IF element = month.
          month = counter.
          EXIT.
        ENDIF.
        counter += 1.
      ENDLOOP.
    ENDIF.

    rv_result = year.

    IF month < 10.
      month = |0{ month }|.
    ENDIF.

    rv_result &&= month.

    IF day < 10.
      day = |0{ day }|.
    ENDIF.

    rv_result &&= day.
  ENDMETHOD.


  METHOD zif_abap_course_basics~fizz_buzz.

    DO 100 TIMES.

      IF ( sy-index MOD 5 = 0 ) AND ( sy-index MOD 3 = 0 ).
        rv_result &&= 'FizzBuzz'.
      ELSEIF sy-index MOD 5 = 0.
        rv_result &&= 'Buzz'.
      ELSEIF sy-index MOD 3 = 0.
        rv_result &&= 'Fizz'.
      ELSE.
        rv_result &&= sy-index.
      ENDIF.

    ENDDO.

  ENDMETHOD.


  METHOD zif_abap_course_basics~get_current_date_time.

    GET TIME STAMP FIELD rv_result.

  ENDMETHOD.


  METHOD zif_abap_course_basics~hello_world.

     DATA(system_user_id) = sy-uname.
     rv_result = |Hello { iv_name }, your system user is { system_user_id }.|.

  ENDMETHOD.


  METHOD zif_abap_course_basics~internal_tables.
  ENDMETHOD.


  METHOD zif_abap_course_basics~open_sql.
  ENDMETHOD.

  METHOD zif_abap_course_basics~scrabble_score.
    DATA(alphabet_as_string) = 'A B C D E F G H I J K L M N O P Q R S T U V W X Y Z'.
    DATA alphabet TYPE TABLE OF string.

    SPLIT alphabet_as_string AT space INTO TABLE alphabet.

    DATA counter TYPE i VALUE 1.
    DATA current_index TYPE i.

    DATA(length) = strlen( iv_word ).

    DO ( length ) TIMES.
      DATA(current_symbol) = iv_word+current_index(1).

      IF current_symbol CO 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvXxYyZz'.
        TRANSLATE current_symbol TO UPPER CASE.

        LOOP AT alphabet INTO DATA(element).
          IF current_symbol = element.
            counter = sy-tabix.
            rv_result += counter.
            EXIT.
          ENDIF.
        ENDLOOP.
      ENDIF.
      current_index += 1.
    ENDDO.


  ENDMETHOD.

ENDCLASS.
