CLASS zcl_carga_libros_mvrg DEFINITION PUBLIC CREATE PUBLIC
  INHERITING FROM cl_demo_classrun.

  PUBLIC SECTION.

    METHODS main REDEFINITION.

  PROTECTED SECTION.

    METHODS load_categorias.
    METHODS load_tipo_acc_x_categ.
    METHODS load_libros.
    METHODS load_clientes.
    METHODS load_libros_x_cliente.

  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_carga_libros_mvrg IMPLEMENTATION.


  METHOD main.

    load_categorias( ).
    load_tipo_acc_x_categ( ).
    load_libros( ).
    load_clientes( ).
    load_libros_x_cliente( ).

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

  METHOD load_libros.

    DATA:
      lt_libro TYPE TABLE OF ztb_libro_mvrg.

    lt_libro = VALUE #( FOR i = 1 THEN i + 1 WHILE i <= 10
      (
        id_libro = i
        titulo = |Libro { i }|
        autor = |Autor { i }|
        categoria = 'A'
        editorial = |Editorial { i }|
        idioma = 'ES'
        paginas = 100
        precio = 500
        moneda = 'MXN'
        formato = 'F' " Físico
      )
    ).

    DELETE FROM ztb_libro_mvrg.
    INSERT ztb_libro_mvrg FROM TABLE @lt_libro.

    COMMIT WORK AND WAIT.

  ENDMETHOD.

  METHOD load_clientes.

    DATA:
      lt_cliente TYPE TABLE OF ztb_cliente_mvrg.

    lt_cliente = VALUE #( FOR i = 1 THEN i + 1 WHILE i <= 9
      (
        id_cliente = i
        tipo_acceso = i
        nombre = |Cliente { i }|
        apellido1 = |Ape1 Cliente { i }|
        apellido2 = |Ape2 Cliente { i }|
        email = |cliente{ i }@corp.com|
      )
    ).

    DELETE FROM ztb_cliente_mvrg.
    INSERT ztb_cliente_mvrg FROM TABLE @lt_cliente.

    COMMIT WORK AND WAIT.

  ENDMETHOD.

  METHOD load_libros_x_cliente.

    DATA:
      lt_cliente_x_libro TYPE TABLE OF ztb_clnt_lb_mvrg.

    lt_cliente_x_libro = VALUE #(
      ( id_cliente = '1' id_libro = '1' )
      ( id_cliente = '1' id_libro = '2' )
      ( id_cliente = '1' id_libro = '3' )
      ( id_cliente = '2' id_libro = '4' )
      ( id_cliente = '2' id_libro = '5' )
      ( id_cliente = '3' id_libro = '1' )
      ( id_cliente = '3' id_libro = '2' )
      ( id_cliente = '3' id_libro = '5' )
      ( id_cliente = '4' id_libro = '2' )
      ( id_cliente = '4' id_libro = '3' )
      ( id_cliente = '5' id_libro = '5' )
      ( id_cliente = '6' id_libro = '6' )
      ( id_cliente = '6' id_libro = '7' )
      ( id_cliente = '6' id_libro = '8' )
    ).

    DELETE FROM ztb_clnt_lb_mvrg.
    INSERT ztb_clnt_lb_mvrg FROM TABLE @lt_cliente_x_libro.

    COMMIT WORK AND WAIT.

  ENDMETHOD.

ENDCLASS.
