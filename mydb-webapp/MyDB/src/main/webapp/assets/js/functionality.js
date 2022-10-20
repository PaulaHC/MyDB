//Container map of the sql tables
const  text_conatiner = new Map();
var delet; 
var symbol = [',', ';', '(', ')', '<', '>', '¿', '?', '¡', '!', '.', ':', '{', '}', '[', ']', "'", '|', '/', "'\'", " "];
var v;
// numbre of rows of the right table (table for the tables name)
var tamTablas = 0;
// array with the atributes of the table
var atributesTable = [];
// array with the values of the attributes of the table
var listaVal = [];
// array with the index of the selected checbox for Primary Keys
var primarys=[];
// index of the selected table to modify it
var ind = 0;
// take the text from the new table to modified an existing table or create a new one
var texto;
// take the text from an existing table
var textoViejo;

//I initialize the map with the header that I will add later
text_conatiner.set('Head','');

/* Function to save in the DB the .sql file and create the pop-up window for
enter the name of the database base */
function SaveInDB() {
    
    if(tamTablas > 0){
        Swal.fire({
            title: 'Introduce the data base name to be saved.',
            input: 'text',
            inputAttributes: {
            autocapitalize: 'off'
            },
            showCancelButton: true,
            confirmButtonText: 'ok',
            showLoaderOnConfirm: true,
            inputValidator: nombre => {
                // if the name is not valid, ask again
                if (!nombre) {
                    return "Introduce the name of your DataBase, please!";
                } else {
                    return undefined;
                }
            }
        }).then(results => {
                if (results.isConfirmed){
                    $('#table>tbody tr').remove();
                    tamTablas = 0;
                    
                    // clean all the tables
                    CleanTable();
                    
                    // call the servlet to save the file in the DB and his name
                    var texto = "";
                    for (let amount of text_conatiner.values()) {
                        texto+=amount;
                    }
                    
                    $("#form").load("SaveDBServlet",{id:texto, name:results.value});
                    
                    showText("YOUR DATABASE HAS BEEN SAVED!");
                    text_conatiner.clear();
                }
        });
    }else{
        alert("You must save at least one table for your DataBase.");
    }
}
/* Function to export the .sql file and create the pop-up window for
enter the name of the database base */
function Export() {
    if(tamTablas > 0){
        Swal.fire({
            title: 'Introduce the data base name to be exported',
            input: 'text',
            inputAttributes: {
            autocapitalize: 'off'
            },
            showCancelButton: true,
            confirmButtonText: 'ok',
            showLoaderOnConfirm: true,
            inputValidator: nombre => {
                // if the name is not valid, ask again
                if (!nombre) {
                    return "Introduce the name of your DataBase, please!";
                } else {
                    return undefined;
                }
            }
        }).then(results => {
                if (results.isConfirmed){
                    $('#table>tbody tr').remove();
                    tamTablas = 0;
                    var filename=results.value+'.sql'; 
                    
                    var contents='';
                    for(let tables of text_conatiner.values())contents=contents+tables;
                    
                    var element = document.createElement('a');
                    element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(contents));
                    element.setAttribute('download', filename);

                    document.body.appendChild(element);

                    element.click();

                    // clean all the tables
                    document.body.removeChild(element);
                    CleanTable();
                    text_conatiner.clear();
                }
        });
    }else{
        alert("You must save at least one table for your DataBase.");
    }
}
/** Function that check if the table just exist and overwrite it or crated a new one. */
function Fill_table(){
    if($("#table-create-input-name").val()!==''){
        if(text_conatiner.has($("#table-create-input-name").val())){
            ConfirmOverwrite($("#table-create-input-name").val());
        }else{
            Create_table();
        }
    }else{
        error('empty table name', 0, 0);
    }

}
/* Function that will create the SQL code of the table once finished and added */
function Create_table(){

    var data='\n',cont=0,error_atribute=false,error_table=false, error_key=false;
    let list = [];
    var primary_key=[];
    //Variables that take the values ​​of the tables of the html page
    var name_table = document.getElementById('table-create-input-name').value;
    var name_atributes =document.getElementsByClassName("form-control border-0");
    var name_values =document.getElementsByName("cell");
    var check_Primary_key =document.getElementsByClassName("form-check-input");

    // Check that the attributes are different and if not call the error function
    for(var i=0;i<($("#tableBD thead tr th").length)-1;i++){
        for(var j=i+1;j<($("#tableBD thead tr th").length)-1;j++){
            if(name_atributes[i].value===name_atributes[j].value && name_atributes[i].value!==''){
                error('several identical atributes', 0, 0);
                error_atribute=true;
            }
        }
        if(name_atributes[i].value !== '') list.push(name_atributes[i].value);
    }
    if (list.length === 0) {
        error('You need at least one atribute for your table', 0, 0);
        error_atribute=true;
    }
    atributesTable.unshift(list);

    //Check that the name of the table is different from empty, and if not call the error function
    if(name_table===''){
        error('empty table name', 0, 0);
        error_table=true;
    }

    // check that the table name not contains any rare simbol
    for(var i = 0; i < name_table.length; i++){
        for(var j = 0; j < symbol.length; j++){
            if(name_table[i]===symbol[j]){ 
                error('The name of the table cannot contain any symbols', -1, i);
                error_table=true;
            }
        }
    }

    // clean empty attributes and their primery key checkbox 
    for(var i = 0; i < ($("#tableBD thead tr:last th").length)-1; i++){
        if(name_atributes[i].value === ''){
            $(".form-check-input").eq(i).prop("checked", false);
            error(("Atribute "+(i+1)+" has not name.\nRemoved or named it."), 0, 0);
            error_atribute=true;
        }
    }

    // check that all attributes not contains any rare simbol or some of them are equal to the table name
    for(var i = 0; i < ($("#tableBD thead tr th").length)-1; i++){
        if(name_atributes[i].value === name_table){ 
            error('The name of the atributes cannot be equal as the table name (Atribute '+(i+1)+').', 0, i);
            error_table=true;
        }
        for(var k=0; k < name_atributes[i].value.length-1; k++){
            for(var j = 0; j < symbol.length; j++){
                if(name_atributes[i].value[k] === symbol[j]){ 
                    error('comas in the table name', 0, i);
                    error_table=true;
                }
            }
        }
    }

    // Check that all least, one atribute is checked as Primary Key
    if(!$('.form-check-input').is(':checked') ) {
        error('Primary Keys', 0, 0);
        error_key = true;
    }

    // Check that the values not contains any simbol
    var t = 1, r = 1;
    $('#tableBD > tbody > tr').each(function(){ 
        $(this).find('td>input').each(function(){ 
            var p =  $(this).val();
            for (let k = 0; k < symbol.length; k++) {
                for (let i = 0; i < p.length; i++) {
                    if(p[i] === symbol[k]){
                        error('comas in the table name', t, r);
                        error_table=true;
                    }
                }
            }
            r += 1;
        });
        r = 1;
        t += 1;
    });

    list = []; // take the values of each atributes
    // re-evaluated all the table 
    name_table = document.getElementById('table-create-input-name').value;
    name_atributes = document.getElementsByClassName("form-control border-0");
    name_values = document.getElementsByName("cell");
    check_Primary_key =document.getElementsByClassName("form-check-input");
    //If there are no errors then we will start producing the table in sql
    if(!error_atribute && !error_table && !error_key){
        var text='drop table if exists '+name_table+';\n'+'create table '+name_table+'(\n';
        for(var i=0;i<($("#tableBD tbody tr").length);i++){
            data=data+'insert into '+name_table+' values (';
            for(var j=1;j<($("#tableBD thead tr th").length);j++){
                if(name_atributes[j].value.length>0){
                    if(j===($("#tableBD thead tr th").length)-1||name_atributes[j+1].value.length===0) 
                        data= data+"'"+name_values[cont].value+"'";
                    else 
                        data= data+"'"+name_values[cont].value+"'"+', ';
                    list.push(name_values[cont].value);
                }
                cont=cont+1;
            }
            data=data+');\n';
        }
        listaVal.unshift(list);
        

        for(var i=0; i<check_Primary_key.length;i++){
            if(check_Primary_key[i].checked)primary_key.push(i);
        }
        primarys.unshift(primary_key);

        for(var i=0;i<($("#tableBD thead tr th").length)-1;i++){
            var name_atribute=name_atributes[i].value;
            var len=len_atribute(i);
            if(name_atribute.length>0) text= text+'\t'+name_atribute+' varchar('+len+'),\n';
        }
        text+='\tprimary key(';
        for(var i=0; i< primary_key.length;i++){
            if(i===(primary_key.length)-1)text=text+name_atributes[primary_key[i]].value;
            else text=text+name_atributes[primary_key[i]].value+',';
        }
        text=text+')\n'+');\n';
        text_conatiner.set(name_table,text+data+'\n');
        texto=text+data;
        $("#table>tbody").prepend("<tr><td scope='row' class='tablesNames' id= '"+name_table+"' onclick='Delete_table(false,"+name_table+")'>"+name_table+"</td></tr>");
        //Once the table is added, clean it and add the default rows
        CleanTable();
        
        tamTablas+=1;
    }
}
// funtion to confirm overwrite a table 
function ConfirmOverwrite(n) {
    Swal.fire({
        inputAttributes: {
            id: "confirm-overWrite"
        },
        title: 'Are you sure?',
        text: "You have an existing table with the same name (" + n + "), do you want to overwrite it?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, overwrite it!'
    }).then((result) => {
        if (result.isConfirmed) {
            text_conatiner.delete(n);
            $("#table tbody tr").each(function(){
                if($(this).find("td").attr("id")===n){
                    $(this).remove();
                }
            });
            Create_table();
            Swal.fire('Overwrite!', 'Your table has been overwrite.');
        } 
    });
}
// function that clean all the table 
function CleanTable(){
    document.getElementById('table-create-input-name').value='';
    $(".form-check-input").prop("checked",false); 
    $("#tableBD > thead > tr > th > input").each(function(){
        $(this).val('');
    });
    $("#tableBD").each(function(){
        $(this).find('tr').each(function(){ 
            $(this).find('td').each(function(){ 
                $(this).find('input').each(function(){ 
                    $(this).val('');
                });
            });
        });
        
    });
}
// Function to show the error that has been made on the screen
function error(where, i, c){
    if(where !== "Primary Keys" && where !== "comas in the table name")
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'Error, ' + where 
        });
    if(where === "Primary Keys")
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'Error, not '+ where +' checked'
        });
    if(where === "comas in the table name" && i!==-1)
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'Error, The attributes (row: ' + i + ', column: ' + c + ') cannot contain any symbols' 
        });
}
//Function to delete a table
function Delete_table(del,obj){
    Selected_Table(); 
    if(del && delet!==null){
        v = delet;
        Swal.fire({
            inputAttributes: {
                id: "confirm-delete"
            },
            title: 'Are you sure you want to remove ' + $(delet).attr('id') + ' ?',
            text: "You won't be able to revert this!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, delete it!'
        }).then((result) => {
            if (result.isConfirmed) {
                text_conatiner.delete($(v).attr('id'));
                v.remove();
                Swal.fire('Deleted!', 'Your table has been deleted.', 'success');
                tamTablas-=1;
            }
        });

    }else{
        delet=obj;
    }
}
// Function to calculate the maximum size of the table values ​​to put the size in the varchar
function len_atribute(colum){
    var max=0;
    for(var i=0;i<($("#tableBD tbody tr").length);i++){
        var total = $('#tableBD>tbody').find('tr').eq(i).find('td').eq(colum).find('input').val();
        if(max<total.length)max=total.length;
    }
    return max;
}
// Function to add a row to the table
function Add_row(){
    if($("#tableBD thead tr th").length>1){
        var col="";
        for(var i=0;i<($("#tableBD thead th").length)-1;i++){
            col=col+"<td><input type='text' class='form-control border-0'name='cell'id='table-create-input-cell' placeholder='Insert value'/></td>";
        }
        $("#tableBD>tbody").append("<tr><th scope='row'class='iden' id='table-create-index'>"+(($("#tableBD tbody tr").length)+1)+"</th>"+col+"</tr>");
    }else{
        error("Yo cannot insert new row without atributtes", 0, 0);
    }
}
//Function to add a column to the table
function Add_column(){
    $('#tableBD thead').find('th').eq(-1).after('<th scope="col"><input type="text"class="form-control border-0"id="table-create-input-cell"placeholder="Insert key"/><label class="form-check-label"id="table-create-primary-key"><input class="form-check-input" id="Primary_Key" type="checkbox"/>Primary</label></th>');
                $('#tableBD').find('tr').each(function () {
                    $(this).find('td').eq(0).after("<td><input type='text' class='form-control border-0'name='cell'id='table-create-input-cell' placeholder='Insert value'/></td>");
                });
}
//Function to remove a row from the table
function Delete_row(){  
    var row = document.getElementById("input-delete-row-col").value;
    var tam = $("#tableBD tr").length;
    if(row > 0){
        if(row!==''){
            if(tam <= row) error("Your table not have the row number " + row, 0,0);
            else document.getElementById("tableBD").deleteRow(row);
        }
        for(var i=0;i<(document.getElementsByClassName("iden").length);i++) document.getElementsByClassName("iden")[i].innerHTML=i+1;    
    }
    document.getElementById("input-delete-row-col").value= "";
}
//Function to remove a column from the table
function Delete_column(){
    var column=document.getElementById("input-delete-row-col").value;
    var tam = $("#tableBD thead tr th").length;
    
    if(column > 0){
        if(tam === 1){
            error("Your table must have at least, one atribute.", 0, 0);
        }else{
            if(column!==''){
                if(tam < column) error("Your table not have the column number " + column, 0, 0);
                else{
                    var tble = document.getElementById('tableBD');
                    var row = tble.rows;  
                    for (var j = 0; j < row.length; j++) {
                        // Deleting the ith cell of each row.
                        row[j].deleteCell(column);
                    }
                }  
            }
        }
    }
    document.getElementById("input-delete-row-col").value= "";
}
// change the class of the selected row to change the background color of that row from table 'id=table'
function Selected_Table(){
    $('#table>tbody>tr').click(function(e){
        var rowIndex = $(this).closest("tr").index();
        ind = rowIndex;

        if(rowIndex!==$("#table tr").length-1){

            if($(this).hasClass('tablesNames')){
                Translate($(this));
                $(this).addClass('tableNamesSelected');
            }else{
                cleanTr();
                $(this).addClass('tablesNames');
            }
        }else{
            cleanTr();
        }
    }); 
}
//Change to the default class all the rows from the table 'id=table'
function cleanTr(){
    $('.tablesNames').each(function(index, element){
      $(element).removeClass('tablesNames');
      $(element).removeClass('tableNamesSelected');
    });
}
// Translate from sql code to html table
function Translate(t){
    var table_container=text_conatiner.get(t.find("td:first").html());
    textoViejo = table_container;
    
    var attrs = [];
    var rowIndex = 0;
    // fill the gap with the name of the selected table
    $("#table-create-input-name").val(t.find("td:first").html());
    rowIndex = t.closest("tr").index();
    attrs = atributesTable[rowIndex];

    // create/delete the necesary columns to fill all the gaps
    var tam = $("#tableBD thead tr th").length-1;
    if(tam < attrs.length){
        while(attrs.length > tam){
            Add_column();
            tam +=1;
        }
    }else{
        while(attrs.length < tam){
            for (var j = 0; j < document.getElementById('tableBD').rows.length; j++) {
                // Deleting the ith cell of each row.
                document.getElementById('tableBD').rows[j].deleteCell(1);
            }
            tam -=1;
        }
    }

    var tamFil = $("#tableBD tbody tr").length;
    while(listaVal[rowIndex].length/tam > tamFil){
        Add_row();
        tamFil +=1;
    }
    
    // fill the thead gaps
    for (let i = 0; i < attrs.length; i++) {
        $($('#tableBD').find('thead > tr > th > input')[i]).val(attrs[i]);
    }

    // select the Primary keys but first, clean all the 
    for (let i = 0; i < attrs.length; i++) {
        $(".form-check-input").eq(i).prop("checked",false); 
    }
    for (let k = 0; k < primarys[rowIndex].length; k++) {
        for (let i = 0; i < attrs.length; i++) {
            if(primarys[rowIndex][k] === i){ 
                $(".form-check-input").eq(i).prop("checked",true); 
            }
        }
    }
    
    // fill the body of the table
    var valor = 0;
    $('#tableBD > tbody').each(function(){ 
        $(this).find('tr').each(function(){ 
            $(this).find('td').each(function(){ 
                $(this).find('input').each(function(){ 
                    $(this).val(listaVal[rowIndex][valor]);
                    valor += 1;
                });
            });
        });
    });
}

//Event for when we click outside the table
window.addEventListener('click', function(e) {
    if (!document.getElementById('table').contains(e.target)) {
        cleanTr();
        Delete_table(false, null);
    }
});

function emptyFile(acceso){
    $("#selectDatabase").hide();
    $("#label_choose").hide();
    $("#download").hide();
    if(acceso){
        Swal.fire("You don´t have any data bases saved.");
    }
}

function translateToTable(ex){
    
    if(ex!==null){
        console.log(ex);
        $('#table>tbody tr:not(:last)').remove();
        CleanTable();
        let tables= ex.split('drop table ');
        for(var k=1;k<tables.length;k++){
            // This is the word to search for
            let term_Final=";create table";
            // To search for the word we do
            let positionFinal = tables[k].indexOf(term_Final);
            var nameTable=tables[k].substring(10,positionFinal );
            
             //We collect the attributes of the newly loaded table
            
            var attrs = [];
            var atrr='';
            let atr= tables[k].split('\t');
            for(var i=1;i<atr.length-1;i++){
                for(var j=0;j<atr[i].length;j++){
                    if(atr[i][j]!==' '){
                        atrr=atrr+atr[i][j];

                    }else{
                         attrs[attrs.length]=atrr;
                         atrr='';
                         break;
                    }

                }
            }
            atributesTable.unshift(attrs);
            //We collect the datas of the newly loaded table
            var datas = [];
            var datt='';
            let dat= tables[k].split("'");
            for(var i=1;i<dat.length;i++){
                for(var j=0;j<dat[i].length;j++){
                    if(dat[i][j]!==')'&&dat[i][j]!==','){
                        datt=datt+dat[i][j];

                    }else{
                         datas[datas.length]=datt;
                         datt='';
                         break;
                    }

                }
            }
            listaVal.unshift(datas);
            //We collect the primarys key of the newly loaded table
            let primerys=[];
            let prim= tables[k].split("primary key(");
            prim= prim[1].split("));");
            prim= prim[0].split(",");
            for(var i=0;i<prim.length;i++){
                for(var j=0;j<attrs.length;j++){
                    if(prim[i]===attrs[j]){
                        primerys[i]=j;
                    }
                }
            }
            primarys.unshift(primerys);
            tables[k]="drop table "+tables[k];
            //We collect the name of the newly loaded table and transformation to text format
            tables[k]= tables[k].split(';');
            for(var i=0;i<tables[k].length-1;i++){
                tables[k][i]=tables[k][i]+';\n';
            }
            tables[k]= tables[k].join('').split('),');
            for(var i=0;i<tables[k].length-1;i++){
                tables[k][i]=tables[k][i]+'),\n';
            }
            tables[k]= tables[k].join('').split('(\t');
            for(var i=0;i<tables[k].length-1;i++){
                tables[k][i]=tables[k][i]+'(\n\t';
            }
            text_conatiner.set(nameTable,tables[k][0]+tables[k][1]);
            tamTablas+=1;
            $("#table>tbody").prepend("<tr><td scope='row' class='tablesNames' id= '"+nameTable+"' onclick='Delete_table(false,"+nameTable+")'>"+nameTable+"</td></tr>");
            
        }
        Selected_Table();
        Selected_Table();
    }
    
}

function showPassword(pass){
    if(pass!==null){
        Swal.fire("Your password is: "+pass);
    }
}

function showText(text){
    if(text!==null){
        Swal.fire({
        position: 'top-end',
        icon: 'success',
        title: text,
        showConfirmButton: false,
        timer: 1500
      })
    }
}

function enterNewNameFile(n){
     Swal.fire({
        inputAttributes: {
            id: "confirm-overWrite"
        },
        title: 'Are you sure?',
        text: "You have an existing table with the same name (" + n + "), do you want to overwrite it?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, overwrite it!'
    }).then((result) => {
        if (result.isConfirmed) {
            Swal.fire('Overwrite!', 'Your table has been overwrite.');
            $("#form").load("SaveDBServlet",{name:result.value});
        } 
    });
}