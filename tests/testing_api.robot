*** Settings ***
Library               RequestsLibrary
Resource              ../resources/api_testing_usuarios.resource
Library               SeleniumLibrary



*** Variable ***

***Test Cases***
Cenario 01: Cadastrar um novo usuario com sucesso na ServeRest
    [Tags]                criar_usuarios

    Criar um usuario novo
    Cadastrar o usuario criado na ServeRest
    Conferir se o usuario foi cadastrado corretamente

Cenario 02: Validar endpoint com token invalido
    [Tags]                cadastrar_produto

    Criar um produto novo
    Cadastrar o produto criado na ServeRest
    Conferir mensagem de retorno

Cenario 03: Cadastrar usuario ja existente
    
    Cadastrar um usuario ja existe
    # Conferir mensagem de retorno