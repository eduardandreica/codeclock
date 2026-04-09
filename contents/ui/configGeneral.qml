import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.kquickcontrols as KQuickControls

Item {
    id: page
    width: childrenRect.width
    height: childrenRect.height

    // Plasma KConfig Bindings
    property string cfg_language: "javascript"
    property alias cfg_colorDecl: declButton.color
    property alias cfg_colorVar: varButton.color
    property alias cfg_colorPunc: puncButton.color
    property alias cfg_colorBrack: brackButton.color
    property alias cfg_colorProp: propButton.color
    property alias cfg_colorNum: numButton.color
    property alias cfg_colorStr: strButton.color

    property alias cfg_colorClockBorder: clockBorderButton.color
    property alias cfg_colorClockHour: clockHourButton.color
    property alias cfg_colorClockMinute: clockMinuteButton.color
    property alias cfg_colorClockSecond: clockSecondButton.color

    Kirigami.FormLayout {
        anchors.left: parent.left
        anchors.right: parent.right

        ComboBox {
            id: langCombo
            Kirigami.FormData.label: "Programmiersprache:"
            model: [
                { text: "JavaScript", value: "javascript" },
                { text: "Python", value: "python" },
                { text: "C#", value: "csharp" },
                { text: "C++", value: "cpp" }
            ]
            textRole: "text"
            valueRole: "value"
            
            // Lade den von Plasma gesetzten Wert
            Component.onCompleted: {
                var lang = page.cfg_language;
                for (var i = 0; i < model.length; ++i) {
                    if (model[i].value === lang) {
                        currentIndex = i;
                        break;
                    }
                }
            }

            // Sync. UI Änderung mit Plasma-Speicher (und aktiviere Anwenden-Button)
            onActivated: {
                page.cfg_language = currentValue;
            }
        }

        Item { Kirigami.FormData.isSection: true } // Abstand

        KQuickControls.ColorButton { id: declButton; Kirigami.FormData.label: "Farbe Keyword (z.B. const):" }
        KQuickControls.ColorButton { id: varButton; Kirigami.FormData.label: "Farbe Variablenname:" }
        KQuickControls.ColorButton { id: puncButton; Kirigami.FormData.label: "Farbe Satzzeichen (=, :, ,):" }
        KQuickControls.ColorButton { id: brackButton; Kirigami.FormData.label: "Farbe Klammern ({, }):" }
        KQuickControls.ColorButton { id: propButton; Kirigami.FormData.label: "Farbe Eigenschaften (day, month):" }
        KQuickControls.ColorButton { id: numButton; Kirigami.FormData.label: "Farbe Zahlen:" }
        KQuickControls.ColorButton { id: strButton; Kirigami.FormData.label: "Farbe Strings/Text:" }

        Item { Kirigami.FormData.isSection: true } // Abstand für die Uhr

        KQuickControls.ColorButton { id: clockBorderButton; Kirigami.FormData.label: "Uhr-Umriss & Punkt:" }
        KQuickControls.ColorButton { id: clockHourButton; Kirigami.FormData.label: "Stundenzeiger:" }
        KQuickControls.ColorButton { id: clockMinuteButton; Kirigami.FormData.label: "Minutenzeiger:" }
        KQuickControls.ColorButton { id: clockSecondButton; Kirigami.FormData.label: "Sekundenzeiger:" }
    }
}
