from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher


# =====================================
# ACTION STRESS ADVICE
# =====================================
class ActionStressAdvice(Action):

    def name(self) -> str:
        return "action_stress_advice"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain):

        message = tracker.latest_message.get("text", "").lower()

        if any(word in message for word in ["deadline", "tugas", "menumpuk"]):

            response = (
                "Saya memahami bahwa tekanan tugas dan deadline dapat terasa berat.\n\n"
                "Cobalah:\n"
                "• Membuat daftar prioritas.\n"
                "• Membagi tugas besar menjadi beberapa bagian kecil.\n"
                "• Memberikan waktu istirahat secara berkala."
            )

        elif any(word in message for word in ["ujian", "nilai", "ipk"]):

            response = (
                "Menghadapi ujian memang dapat menimbulkan stres.\n\n"
                "Persiapkan jadwal belajar yang realistis, fokus pada materi penting, "
                "dan usahakan tidur yang cukup sebelum ujian."
            )

        elif any(word in message for word in ["skripsi", "revisi"]):

            response = (
                "Proses pengerjaan skripsi memang sering menimbulkan tekanan.\n\n"
                "Cobalah menyelesaikan target sedikit demi sedikit dan jangan ragu "
                "berdiskusi dengan dosen pembimbing apabila mengalami kesulitan."
            )

        else:

            response = (
                "Saya memahami bahwa Anda sedang mengalami stres akademik.\n\n"
                "Menjaga keseimbangan antara belajar, istirahat, dan aktivitas pribadi "
                "dapat membantu mengurangi tekanan yang dirasakan."
            )

        dispatcher.utter_message(text=response)

        return []


# =====================================
# ACTION ANXIETY ADVICE
# =====================================
class ActionAnxietyAdvice(Action):

    def name(self) -> str:
        return "action_anxiety_advice"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain):

        message = tracker.latest_message.get("text", "").lower()

        if "presentasi" in message:

            response = (
                "Merasa gugup sebelum presentasi adalah hal yang wajar.\n\n"
                "Latih materi beberapa kali dan tarik napas perlahan sebelum mulai berbicara."
            )

        elif "masa depan" in message or "gagal" in message:

            response = (
                "Kekhawatiran mengenai masa depan sering dialami banyak mahasiswa.\n\n"
                "Cobalah fokus pada langkah yang bisa dilakukan hari ini daripada "
                "terlalu memikirkan kemungkinan yang belum tentu terjadi."
            )

        else:

            response = (
                "Perasaan cemas dapat dialami siapa saja.\n\n"
                "Anda dapat mencoba latihan pernapasan sederhana:\n"
                "• Tarik napas selama 4 detik.\n"
                "• Tahan selama 4 detik.\n"
                "• Hembuskan perlahan selama 6 detik.\n\n"
                "Jika kecemasan berlangsung lama atau mengganggu aktivitas sehari-hari, "
                "pertimbangkan untuk berkonsultasi dengan psikolog atau konselor."
            )

        dispatcher.utter_message(text=response)

        return []