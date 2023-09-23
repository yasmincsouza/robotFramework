*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://www.amazon.com.br/
${MENU_ELETRONICOS}    //a[@href='/Eletronicos-e-Tecnologia/b/?ie=UTF8&node=16209062011&ref_=nav_cs_electronics'][contains(.,'Eletrônicos')]
${HEADER_ELETRONICOS}    //h1[contains(.,'Eletrônicos e Tecnologia')]

*** Keywords ***
Abrir o navegador
    Open Browser    browser=chrome     options=add_experimental_option("detach", True)
    Maximize Browser Window

Fechar o navegador
    Capture Page Screenshot
    Close Browser

Acessar a home page do site Amazon.com.br
    Go To    url=${URL}
    Wait Until Element Is Visible    locator=${MENU_ELETRONICOS}

Verificar se o título da página fica "${TITULO}"
    Title Should Be    title=${TITULO}

Entrar no menu "Eletrônicos"
    Click Element    locator=${MENU_ELETRONICOS}

Verificar se aparece a frase "${TEXTO_ELETRONICOS}"
    Wait Until Page Contains    text=${TEXTO_ELETRONICOS}
    Wait Until Element Is Visible    locator=${HEADER_ELETRONICOS}

Verificar se aparece a categoria "${NOME_CATEGORIA}"
    Element Should Be Visible    locator=//a[@aria-label='${NOME_CATEGORIA}']

Digitar o nome de produto "${PRODUTO}" no campo de pesquisa
    Input Text    locator=twotabsearchtextbox    text=${PRODUTO}

Clicar no botão de pesquisa
    Click Element    locator=nav-search-submit-button

Verificar o resultado da pesquisa se está listando o produto "${PRODUTO}"
    Wait Until Element Is Visible    locator=//span[@class='a-size-base-plus a-color-base a-text-normal'][contains(.,'${PRODUTO}')]

# GHERKIN STEPS
Dado que estou na home page da Amazon.com.br
    Acessar a home page do site Amazon.com.br

Então o título da página deve ficar "Eletrônicos e Tecnologia | Amazon.com.br"
    Verificar se o título da página fica "Amazon.com.br | Tudo pra você, de A a Z."

Quando acessar o menu "Eletrônicos"
    Entrar no menu "Eletrônicos"

E o texto "Eletrônicos e Tecnologia" deve ser exibido na página
    Verificar se aparece a frase "Eletrônicos e Tecnologia"

E a categoria "Computadores e Informática" deve ser exibida na página
    Verificar se aparece a categoria "Computadores e Informática"

Quando pesquisar pelo produto "Xbox Series S"
    Digitar o nome de produto "Xbox Series S" no campo de pesquisa
    Clicar no botão de pesquisa

Então o título da página deve ficar "Amazon.com.br : Xbox Series S"
    Verificar se o título da página fica "Amazon.com.br : Xbox Series S"

E um produto da linha "Xbox Series S" deve ser mostrado na página
    Verificar o resultado da pesquisa se está listando o produto "Console Xbox Series S"