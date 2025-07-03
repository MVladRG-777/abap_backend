CLASS zcl_carga_libros_mvrg DEFINITION PUBLIC CREATE PUBLIC
  INHERITING FROM cl_demo_classrun.

  PUBLIC SECTION.

    METHODS main REDEFINITION.

  PROTECTED SECTION.

    METHODS load_categorias.
    METHODS load_tipo_acc_x_categ.

    METHODS next_id_libro
      IMPORTING
        iv_id_libro        TYPE zde_id_libro_mvrg
      RETURNING
        VALUE(rv_id_libro) TYPE zde_id_libro_mvrg.

  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_carga_libros_mvrg IMPLEMENTATION.


  METHOD main.

    DATA:
      lt_libro    TYPE TABLE OF ztb_libro_mvrg,
      lv_id_libro TYPE zde_id_libro_mvrg.

    load_categorias( ).
    load_tipo_acc_x_categ( ).

  ENDMETHOD.

  METHOD next_id_libro.
    rv_id_libro += 1.
  ENDMETHOD.

  METHOD load_categorias.

    DATA:
      lt_categoria TYPE TABLE OF ztb_catego_mvrg.

    lt_categoria = VALUE #(
      ( categoria = 'A' descripcion = |Categoria A| )
      ( categoria = 'B' descripcion = |Categoria B| )
      ( categoria = 'C' descripcion = |Categoria B| )
    ).

    DELETE FROM ztb_catego_mvrg.
    INSERT ztb_catego_mvrg FROM TABLE @lt_categoria.

    COMMIT WORK AND WAIT.

  ENDMETHOD.

  METHOD load_tipo_acc_x_categ.

    DATA:
      lt_acc_cat TYPE TABLE OF ztb_acc_cat_mvrg.

    lt_acc_cat = VALUE #(
      ( categoria = 'A' tipo_acceso = '1' )
      ( categoria = 'A' tipo_acceso = '2' )
      ( categoria = 'A' tipo_acceso = '3' )
      ( categoria = 'B' tipo_acceso = '1' )
      ( categoria = 'C' tipo_acceso = '1' )
    ).

    DELETE FROM ztb_acc_cat_mvrg.
    INSERT ztb_acc_cat_mvrg FROM TABLE @lt_acc_cat.

    COMMIT WORK AND WAIT.

  ENDMETHOD.

ENDCLASS.
