import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore

PlasmoidItem {
    id: root
    preferredRepresentation: fullRepresentation
    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground

    fullRepresentation: Item {
        id: mainContainer
        implicitWidth: 550
        implicitHeight: 200

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: updateClock()
        }

        // QML Engine trackt diese Properties nativ und absolut zuverlässig
        property string tLang: Plasmoid.configuration.language
        property string tCDecl: Plasmoid.configuration.colorDecl
        property string tCVar: Plasmoid.configuration.colorVar
        property string tCPunc: Plasmoid.configuration.colorPunc
        property string tCBrack: Plasmoid.configuration.colorBrack
        property string tCProp: Plasmoid.configuration.colorProp
        property string tCNum: Plasmoid.configuration.colorNum
        property string tCStr: Plasmoid.configuration.colorStr

        onTLangChanged: updateClock()
        onTCDeclChanged: updateClock()
        onTCVarChanged: updateClock()
        onTCPuncChanged: updateClock()
        onTCBrackChanged: updateClock()
        onTCPropChanged: updateClock()
        onTCNumChanged: updateClock()
        onTCStrChanged: updateClock()

        function updateClock() {
            var now = new Date();
            var h = now.getHours();
            var m = now.getMinutes();
            var s = now.getSeconds();

            // Zeiger rotieren
            hourHand.rotation = (h % 12) * 30 + m * 0.5;
            minuteHand.rotation = m * 6 + s * 0.1;
            secondHand.rotation = s * 6;

            var startOfDay = new Date(now.getFullYear(), now.getMonth(), now.getDate());
            var progress = (((now - startOfDay) / 86400000) * 100).toFixed(2);

            function pad(n) { return n < 10 ? '0' + n : n; }
            
            var day = pad(now.getDate());
            var month = pad(now.getMonth() + 1);
            var year = now.getFullYear();
            var days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
            var dayOfWeek = days[now.getDay()];

            // Farben über gebundene Properties abrufen
            var cDecl = Plasmoid.configuration.colorDecl;
            var cVar = Plasmoid.configuration.colorVar;
            var cPunc = Plasmoid.configuration.colorPunc;
            var cBrack = Plasmoid.configuration.colorBrack;
            var cProp = Plasmoid.configuration.colorProp;
            var cNum = Plasmoid.configuration.colorNum;
            var cStr = Plasmoid.configuration.colorStr;

            var lang = Plasmoid.configuration.language;
            var text = "";

            // --- SPRACH-LOGIK ---
            if (lang === "python") {
                text = `<font color="${cVar}">current_time</font> <font color="${cPunc}">=</font> <font color="${cBrack}">{</font><br>` +
                       `&nbsp;&nbsp;<font color="${cPunc}">"</font><font color="${cProp}">day</font><font color="${cPunc}">":</font> <font color="${cNum}">${day}</font><font color="${cPunc}">,</font><br>` +
                       `&nbsp;&nbsp;<font color="${cPunc}">"</font><font color="${cProp}">month</font><font color="${cPunc}">":</font> <font color="${cNum}">${month}</font><font color="${cPunc}">,</font><br>` +
                       `&nbsp;&nbsp;<font color="${cPunc}">"</font><font color="${cProp}">year</font><font color="${cPunc}">":</font> <font color="${cNum}">${year}</font><font color="${cPunc}">,</font><br>` +
                       `&nbsp;&nbsp;<font color="${cPunc}">"</font><font color="${cProp}">day_of_week</font><font color="${cPunc}">":</font> <font color="${cPunc}">"</font><font color="${cStr}">${dayOfWeek}</font><font color="${cPunc}">",</font><br>` +
                       `&nbsp;&nbsp;<font color="${cPunc}">"</font><font color="${cProp}">hour</font><font color="${cPunc}">":</font> <font color="${cNum}">${pad(h)}</font><font color="${cPunc}">,</font><br>` +
                       `&nbsp;&nbsp;<font color="${cPunc}">"</font><font color="${cProp}">minute</font><font color="${cPunc}">":</font> <font color="${cNum}">${pad(m)}</font><font color="${cPunc}">,</font><br>` +
                       `&nbsp;&nbsp;<font color="${cPunc}">"</font><font color="${cProp}">second</font><font color="${cPunc}">":</font> <font color="${cNum}">${pad(s)}</font><font color="${cPunc}">,</font><br>` +
                       `&nbsp;&nbsp;<font color="${cPunc}">"</font><font color="${cProp}">day_progress</font><font color="${cPunc}">":</font> <font color="${cNum}">${progress}</font><br>` +
                       `<font color="${cBrack}">}</font>`;
            } 
            else if (lang === "csharp") {
                text = `<font color="${cDecl}">var</font> <font color="${cVar}">currentTime</font> <font color="${cPunc}">=</font> <font color="${cDecl}">new</font> <font color="${cBrack}">{</font><br>` +
                       `&nbsp;&nbsp;<font color="${cProp}">Day</font> <font color="${cPunc}">=</font> <font color="${cNum}">${day}</font><font color="${cPunc}">,</font><br>` +
                       `&nbsp;&nbsp;<font color="${cProp}">Month</font> <font color="${cPunc}">=</font> <font color="${cNum}">${month}</font><font color="${cPunc}">,</font><br>` +
                       `&nbsp;&nbsp;<font color="${cProp}">Year</font> <font color="${cPunc}">=</font> <font color="${cNum}">${year}</font><font color="${cPunc}">,</font><br>` +
                       `&nbsp;&nbsp;<font color="${cProp}">DayOfWeek</font> <font color="${cPunc}">=</font> <font color="${cPunc}">"</font><font color="${cStr}">${dayOfWeek}</font><font color="${cPunc}">",</font><br>` +
                       `&nbsp;&nbsp;<font color="${cProp}">Hour</font> <font color="${cPunc}">=</font> <font color="${cNum}">${pad(h)}</font><font color="${cPunc}">,</font><br>` +
                       `&nbsp;&nbsp;<font color="${cProp}">Minute</font> <font color="${cPunc}">=</font> <font color="${cNum}">${pad(m)}</font><font color="${cPunc}">,</font><br>` +
                       `&nbsp;&nbsp;<font color="${cProp}">Second</font> <font color="${cPunc}">=</font> <font color="${cNum}">${pad(s)}</font><font color="${cPunc}">,</font><br>` +
                       `&nbsp;&nbsp;<font color="${cProp}">DayProgress</font> <font color="${cPunc}">=</font> <font color="${cNum}">${progress}</font><font color="${cDecl}">f</font><br>` +
                       `<font color="${cBrack}">}</font><font color="${cPunc}">;</font>`;
            } 
            else if (lang === "cpp") {
                text = `<font color="${cDecl}">struct</font> <font color="${cBrack}">{</font><br>` +
                       `&nbsp;&nbsp;<font color="${cDecl}">int</font> <font color="${cProp}">day</font> <font color="${cPunc}">=</font> <font color="${cNum}">${day}</font><font color="${cPunc}">;</font><br>` +
                       `&nbsp;&nbsp;<font color="${cDecl}">int</font> <font color="${cProp}">month</font> <font color="${cPunc}">=</font> <font color="${cNum}">${month}</font><font color="${cPunc}">;</font><br>` +
                       `&nbsp;&nbsp;<font color="${cDecl}">int</font> <font color="${cProp}">year</font> <font color="${cPunc}">=</font> <font color="${cNum}">${year}</font><font color="${cPunc}">;</font><br>` +
                       `&nbsp;&nbsp;<font color="${cDecl}">const char*</font> <font color="${cProp}">dayOfWeek</font> <font color="${cPunc}">=</font> <font color="${cPunc}">"</font><font color="${cStr}">${dayOfWeek}</font><font color="${cPunc}">";</font><br>` +
                       `&nbsp;&nbsp;<font color="${cDecl}">int</font> <font color="${cProp}">hour</font> <font color="${cPunc}">=</font> <font color="${cNum}">${pad(h)}</font><font color="${cPunc}">;</font><br>` +
                       `&nbsp;&nbsp;<font color="${cDecl}">int</font> <font color="${cProp}">minute</font> <font color="${cPunc}">=</font> <font color="${cNum}">${pad(m)}</font><font color="${cPunc}">;</font><br>` +
                       `&nbsp;&nbsp;<font color="${cDecl}">int</font> <font color="${cProp}">second</font> <font color="${cPunc}">=</font> <font color="${cNum}">${pad(s)}</font><font color="${cPunc}">;</font><br>` +
                       `&nbsp;&nbsp;<font color="${cDecl}">float</font> <font color="${cProp}">dayProgress</font> <font color="${cPunc}">=</font> <font color="${cNum}">${progress}</font><font color="${cDecl}">f</font><font color="${cPunc}">;</font><br>` +
                       `<font color="${cBrack}">}</font> <font color="${cVar}">currentTime</font><font color="${cPunc}">;</font>`;
            } 
            else { // Default: JavaScript
                text = `<font color="${cDecl}">const</font> <font color="${cVar}">currentTime</font> <font color="${cPunc}">=</font> <font color="${cBrack}">{</font><br>` +
                       `&nbsp;&nbsp;<font color="${cProp}">day</font><font color="${cPunc}">:</font> <font color="${cNum}">${day}</font><font color="${cPunc}">,</font><br>` +
                       `&nbsp;&nbsp;<font color="${cProp}">month</font><font color="${cPunc}">:</font> <font color="${cNum}">${month}</font><font color="${cPunc}">,</font><br>` +
                       `&nbsp;&nbsp;<font color="${cProp}">year</font><font color="${cPunc}">:</font> <font color="${cNum}">${year}</font><font color="${cPunc}">,</font><br>` +
                       `&nbsp;&nbsp;<font color="${cProp}">dayOfWeek</font><font color="${cPunc}">:</font> <font color="${cPunc}">"</font><font color="${cStr}">${dayOfWeek}</font><font color="${cPunc}">",</font><br>` +
                       `&nbsp;&nbsp;<font color="${cProp}">hour</font><font color="${cPunc}">:</font> <font color="${cNum}">${pad(h)}</font><font color="${cPunc}">,</font><br>` +
                       `&nbsp;&nbsp;<font color="${cProp}">minute</font><font color="${cPunc}">:</font> <font color="${cNum}">${pad(m)}</font><font color="${cPunc}">,</font><br>` +
                       `&nbsp;&nbsp;<font color="${cProp}">second</font><font color="${cPunc}">:</font> <font color="${cNum}">${pad(s)}</font><font color="${cPunc}">,</font><br>` +
                       `&nbsp;&nbsp;<font color="${cProp}">dayProgress</font><font color="${cPunc}">:</font> <font color="${cNum}">${progress}</font><font color="${cPunc}">%</font><br>` +
                       `<font color="${cBrack}">}</font><font color="${cPunc}">;</font>`;
            }

            codeText.text = text;
        }

        Component.onCompleted: updateClock()

        RowLayout {
            anchors.centerIn: parent
            spacing: 56
            scale: Math.min(mainContainer.width / mainContainer.implicitWidth, 
                            mainContainer.height / mainContainer.implicitHeight)
            transformOrigin: Item.Center

            Text {
                id: codeText
                font.family: "Courier New, monospace"
                font.pixelSize: 22 
                textFormat: Text.RichText
                lineHeight: 1.3
            }

            Rectangle {
                width: 140; height: 140; radius: 70
                color: "transparent"; border.color: "#b4c1d4"; border.width: 3

                Rectangle {
                    id: hourHand
                    width: 5.6; height: 42; color: "#b4c1d4"
                    x: 70 - (width / 2); y: 70 - height
                    transformOrigin: Item.Bottom
                }
                Rectangle {
                    id: minuteHand
                    width: 4.2; height: 56; color: "#b4c1d4"
                    x: 70 - (width / 2); y: 70 - height
                    transformOrigin: Item.Bottom
                }
                Rectangle {
                    id: secondHand
                    width: 2.8; height: 63; color: "#ce9178"
                    x: 70 - (width / 2); y: 70 - height
                    transformOrigin: Item.Bottom
                }
                Rectangle { width: 10; height: 10; radius: 5; color: "#b4c1d4"; x: 65; y: 65 }
            }
        }
    }
}
