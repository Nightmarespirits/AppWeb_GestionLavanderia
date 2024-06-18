<%-- 
    Document   : print
    Created on : 11 jun. 2024, 9:56:53 a. m.
    Author     : Clider Fernando Tutaya Rivera 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Factura</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            width: 300px;
            margin: 0 auto;
        }
        .invoice-box {
            width: 100%;
            border: 1px solid #eee;
            padding: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.15);
            font-size: 12px;
            line-height: 18px;
        }
         .invoice-box table {
            width: 100%;
            line-height: inherit;
            text-align: left;
        }
        .invoice-box table td {
            padding: 5px;
            vertical-align: top;
        }
        .invoice-box table tr td:nth-child(2) {
            text-align: right;
        }
        .invoice-box table tr.top table td {
            padding-bottom: 10px;
        }
        .invoice-box table tr.top table td.title {
            font-size: 20px;
            line-height: 20px;
            color: #333;
        }
        .invoice-box table tr.information table td {
            padding-bottom: 20px;
        }
        .invoice-box table tr.heading td {
            background: #eee;
            border-bottom: 1px solid #ddd;
            font-weight: bold;
        }
        .invoice-box table tr.details td {
            padding-bottom: 20px;
        }
        .invoice-box table tr.item td {
            border-bottom: 1px solid #eee;
        }
        .invoice-box table tr.item.last td {
            border-bottom: none;
        }
        .invoice-box table tr.total td:nth-child(2) {
            border-top: 2px solid #eee;
            font-weight: bold;
        }
        .header, .footer {
            text-align: center;
        }
        .header {
            margin-bottom: 20px;
        }
        .content {
            margin-bottom: 20px;
        }
        .content .row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        .content .column {
            flex: 1;
        }
        .content .column-right {
            text-align: right;
        }
        .table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .table th, .table td {
            border: 1px solid #000;
            padding: 5px;
            text-align: left;
        }
        .table th {
            background-color: #f2f2f2;
        }
        .observaciones {
            margin-top: 20px;
            font-size: 0.9em;
        }
        .observaciones p {
            margin: 5px 0;
        }
    </style>
</head>
<body>
    <div class="invoice-box">
    <div class="header">
        <h1>LAVANDERIA SPEED WASH</h1>
        <h4>ORDEN DE TRABAJO #</h4>
        <h2 id="orderNumber"></h2>
    </div>
    <div class="content">
        <div class="row">
            <div class="column">
                <p><strong>Cliente</strong></p>
                <p id="clienteNom"></p>
                <p id="clienteAp"></p>
                <p id="clienteTel"></p>
                <p id="clienteNumDoc"></p>
            </div>
            <div class="column-right">
                <p id="fecRecep"></p>
                <p id="horaRecep"></p>
            </div>
        </div>
        <table class="heading">
            <tr>
               <td>Servicio</td>
                <td>Precio</td> 
            </tr>
                
            <tbody id="items"></tbody>
            <tr class="total">
                <td></td>
                <td>Total: <span id="total"></span></td>
            </tr>
        </table>
            
        
        <div class="row">
            <div class="column">
                <p>Fecha y Hora entrega :</p>
                <p id="fecyhoraEntrega"></p>
            </div>
        </div>
        <div class="row">
            <div class="column">
                <p>Atendido por :</p>
            </div>
            <div class="column-right">
                <p id="user"></p>
            </div>
        </div>
        <br><!-- comment -->
        <hr>
        <div class="observaciones">
            <p>1.- LAS PRENDAS QUE NO HAYAN SIDO RECOGIDAS HASTA 90 DIAS DESPUÉS DE SER RECEPCIONADAS SE DONARÁ A INSTITUCIONES DE CARIDAD.</p>
            <p>2.- NO NOS RESPONSABILIZAMOS POR PRENDAS QUE SE DETERIOREN POR ESTAR DEMASIADO USADAS, MALOS TINTES Y/O TEJIDOS.</p>
            <p>3.- NO NOS RESPONSABILIZAMOS POR EL DETERIORO DE EMBLEMAS, ADORNOS, CIERRES QUE SE PRODUZCAN EN EL PROCESO DE LAVADO.</p>
            <p>4.- POR ROPA PERDIDA O TOTALMENTE MALOGRADA SE INDEMNIZARA HASTA 10 VECES EL VALOR DEL LAVADO.</p>
            <p>5.- PASADOS LOS 60 DIAS, SE RECARGARÁ 20% POR ALMACENAMIENTO.</p>
        </div>
    </div>
    </div>

    <script>
        
        const ordData = JSON.parse(localStorage.getItem('printData'));
        console.log(ordData);
        
        document.getElementById('orderNumber').innerText = ordData.nroOrden;
        document.getElementById('fecRecep').innerText = 'Fecha:' + ' ' + ordData.fecOrden;
        document.getElementById('horaRecep').innerText = 'Hora:' +' ' + ordData.horaOrden;
        document.getElementById('fecyhoraEntrega').innerText = ordData.fecEntrega + " " + ordData.horaEntrega;
        document.getElementById('clienteNom').innerText = ordData.cliente.nombres;
        document.getElementById('clienteAp').innerText = ordData.cliente.apellidos;
        document.getElementById('clienteTel').innerText = 'Tel:' + ' ' + ordData.cliente.tel;
        document.getElementById('clienteNumDoc').innerText = 'DNI:' + ' ' + ordData.cliente.numDoc;
        document.getElementById('user').innerText = ordData.usr.apellidos + ordData.usr.nombres;
        
        const itemsContainer = document.getElementById('items');
        let total = 0;
        
        ordData.listDetalles.forEach(item => {
            const row = document.createElement('tr');
            row.className = 'item';
            row.innerHTML = '<td>' + item.tipoServ + '(' + item.prenda + ')</td>' +
                            '<td>' + item.subtotal + '</td>';
            itemsContainer.appendChild(row);
            total += parseFloat(item.subtotal);
        });
        
        document.getElementById('total').innerText = total.toFixed(2);
        window.print();
        
        
         // Interceptar el evento de navegación hacia atrás
        window.addEventListener('popstate', function(event) {
            // Redirigir a index.html
            window.location.href = '/Web_SistemaLavanderiaControl_SLC/nuevaOrden.jsp';
        });

        // Añadir una entrada al historial para que la navegación hacia atrás lo detecte
        history.pushState(null, '', location.href);
        
        
    </script>
</body>
</html>
