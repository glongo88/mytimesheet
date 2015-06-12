package calcolouscita

import it.longo.RecordTime
import org.joda.time.DateMidnight
import org.joda.time.DateTime
import org.joda.time.LocalDate
import org.joda.time.format.DateTimeFormat
import org.joda.time.format.DateTimeFormatter

class UtilsTaglibTagLib {
    //static defaultEncodeAs = [taglib:'html']
    //static encodeAsForTags = [tagName: [taglib:'html'], otherTagName: [taglib:'none']]

    static namespace = "util"

    def springSecurityService

    def printTable = { attrs ->

        def month = attrs.month
        def year = attrs.year
        Map records = attrs.records
        def checkOggi = false

        DateTime dateTime = new DateTime(year.toInteger(), month.toInteger(), 1, 0, 0);
        DateTimeFormatter fmt = DateTimeFormat.forPattern("dd/MM/yyyy");
        DateTime lastDate = dateTime.dayOfMonth().withMaximumValue();
        DateTime firstDate = dateTime.dayOfMonth().withMinimumValue()
        firstDate = firstDate.minusDays(1)

        DateMidnight oggi = new DateMidnight()

        for (int i=firstDate.plusDays(1).dayOfMonth().get(); i<=lastDate.dayOfMonth().get(); i++) {
            firstDate = firstDate.plusDays(1)
            def parsedDate = firstDate.toDate().parse("dd/MM/yyyy", fmt.print(firstDate))
            parsedDate.set(hourOfDay: 0, minute: 0, second: 0)
            def recordFound = records.get(parsedDate)
            checkOggi = firstDate.getMillis() == oggi.getMillis() ? true : false
            out << g.render(template: "/recordTime/recordRow",model: [recordFound:recordFound, currData: parsedDate, count: i, checkOggi: checkOggi])
        }

    }

    def printMinutesSimple = { attrs ->
        def minutiIniziali = attrs.minuti

        if(minutiIniziali) {
            def ore = (int)minutiIniziali/60
            def minuti = (int)minutiIniziali%60

            out << "${String.format("%02d", ore)}:${String.format("%02d", minuti)}"
        } else {
            out << "0:0"
        }
    }

    def printMinutes = { attrs ->
        def minutiIniziali = attrs.minuti

        if(minutiIniziali) {
            def ore = (int)minutiIniziali/60
            def minuti = (int)minutiIniziali%60

            out << "<span class='big'>${ore}</span> ore e <span class='big'>${minuti}</span> min"
        } else {
            out << ""
        }
    }
}
