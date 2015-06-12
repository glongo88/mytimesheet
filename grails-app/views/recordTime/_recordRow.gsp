<g:if test="${recordFound}">
    <tr class="${checkOggi?'record-oggi':''}" style="${(formatDate(format: 'EEE', date: currData)=='sab' || formatDate(format: 'EEE', date: currData)=='dom')?'background-color: #FFF5EE;':''}">
        <td id="dataRecord${count}">${formatDate(format: 'EEEE dd', date: currData)}</td>
        <td><a href="#" class="editable" id="entrataTime-${count}" data-name="entrataTime" data-type="time" data-pk="${recordFound.id}" data-url="${createLink(controller: 'recordTime', action: 'editLive')}" data-title="Inserisci ora entrata">${fieldValue(bean: recordFound, field: "entrataTime")}</a></td>
        <td><a href="#" class="editable" id="inizioPausaTime-${count}" data-name="inizioPausaTime" data-type="time" data-pk="${recordFound.id}" data-url="${createLink(controller: 'recordTime', action: 'editLive')}" data-title="Inserisci ora inizio pausa">${fieldValue(bean: recordFound, field: "inizioPausaTime")}</a></td>
        <td><a href="#" class="editable" id="finePausaTime-${count}" data-name="finePausaTime" data-type="time" data-pk="${recordFound.id}" data-url="${createLink(controller: 'recordTime', action: 'editLive')}" data-title="Inserisci ora fine pausa">${fieldValue(bean: recordFound, field: "finePausaTime")}</a></td>
        <td><a href="#" class="editable" id="uscitaTime-${count}" data-name="uscitaTime" data-type="time" data-pk="${recordFound.id}" data-url="${createLink(controller: 'recordTime', action: 'editLive')}" data-title="Inserisci ora uscita">${fieldValue(bean: recordFound, field: "uscitaTime")}</a></td>
        <td id="totale-${count}"><util:printMinutes minuti="${recordFound.totaleLavorato}"/></td>
        <td id="straordinario-${count}"><util:printMinutes minuti="${recordFound.minutiStraordinario}"/></td>
        <td>
            <button id="eliminaButton${count}" onclick="confirmDelete(${recordFound.id})" class="btn btn-danger modify" data-toggle="tooltip" data-placement="top" title="Elimina"><i class="fa fa-trash"></i></button>
        </td>
    </tr>
</g:if>
<g:else>
    <tr class="${checkOggi?'record-oggi':''}" style="${(formatDate(format: 'EEE', date: currData)=='sab' || formatDate(format: 'EEE', date: currData)=='dom')?'background-color: #FFF5EE;':''}">
        <td id="dataRecord${count}" data-formatted="${formatDate(format: 'dd/MM/yyyy', date: currData)}">${formatDate(format: 'EEEE dd', date: currData)}</td>
        <td><a href="#" id="entrataTime-${count}" class="editable myeditable${count} editable-click editable-empty" data-type="time" data-name="entrataTime" data-original-title="Inserisci ora entrata">vuoto</a></td>
        <td><a href="#" id="inizioPausaTime-${count}" class="editable myeditable${count} editable-click editable-empty" data-type="time" data-name="inizioPausaTime" data-original-title="Inserisci ora inizio pausa">vuoto</a></td>
        <td><a href="#" id="finePausaTime-${count}" class="editable myeditable${count} editable-click editable-empty" data-type="time" data-name="finePausaTime" data-title="Inserisci ora fine pausa">vuoto</a></td>
        <td><a href="#" id="uscitaTime-${count}" class="editable myeditable${count} editable-click editable-empty" data-type="time" data-name="uscitaTime" data-original-title="Inserisci ora uscita">vuoto</a></td>
        <td></td>
        <td></td>
        <td><button id="saveButton${count}" value="${count}" class="btn btn-success btn-save-data" data-toggle="tooltip" data-placement="top" title="Salva" style="display: none;"><i class="fa fa-ok-sign"></i></button></td>
    </tr>
</g:else>
