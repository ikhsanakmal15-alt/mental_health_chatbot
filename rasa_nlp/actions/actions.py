from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher
import random


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

            responses = [
                """Saya memahami bahwa tugas dan deadline yang menumpuk dapat terasa sangat melelahkan.

Cobalah membuat daftar prioritas berdasarkan tingkat urgensi. Fokuslah menyelesaikan satu tugas terlebih dahulu daripada memikirkan semuanya sekaligus.

Ingat, Anda tidak harus menyelesaikan semuanya dalam satu waktu.""",

                """Beban tugas yang banyak memang dapat menimbulkan stres.

Mungkin Anda bisa membagi tugas besar menjadi beberapa target kecil yang lebih mudah dicapai.

Setiap progres kecil tetap merupakan kemajuan yang berarti."""
            ]

        elif any(word in message for word in ["ujian", "nilai", "ipk"]):

            responses = [
                """Kecemasan menghadapi ujian atau nilai adalah hal yang cukup umum dialami mahasiswa.

Fokuslah pada persiapan yang masih bisa Anda lakukan hari ini daripada terlalu memikirkan hasil akhirnya.

Belajar secara konsisten biasanya lebih efektif daripada belajar berlebihan dalam waktu singkat.""",

                """Tekanan untuk mendapatkan nilai yang baik memang tidak mudah.

Namun nilai bukan satu-satunya ukuran kemampuan seseorang.

Cobalah menetapkan target yang realistis dan berikan apresiasi terhadap usaha yang sudah Anda lakukan."""
            ]

        elif any(word in message for word in ["skripsi", "revisi"]):

            responses = [
                """Mengerjakan skripsi sering kali menjadi salah satu sumber stres terbesar bagi mahasiswa.

Cobalah memecah pekerjaan menjadi target-target kecil yang dapat diselesaikan setiap hari.

Kemajuan yang konsisten biasanya lebih efektif daripada menunggu motivasi datang.""",

                """Revisi skripsi memang bisa terasa melelahkan dan menguras energi.

Namun revisi merupakan bagian normal dari proses akademik.

Jangan terlalu keras pada diri sendiri jika progres terasa lambat."""
            ]

        elif any(word in message for word in ["burnout", "kelelahan", "capek", "lelah"]):

            responses = [
                """Apa yang Anda rasakan terdengar seperti kelelahan mental yang cukup berat.

Burnout sering muncul ketika seseorang terus bekerja tanpa waktu pemulihan yang cukup.

Jika memungkinkan, berikan waktu istirahat sejenak dan lakukan aktivitas yang dapat membantu Anda rileks.""",

                """Tubuh dan pikiran memiliki batas kemampuan.

Jika Anda merasa kelelahan terus-menerus, mungkin ini saat yang tepat untuk memperlambat ritme dan memberi ruang bagi diri sendiri untuk beristirahat."""
            ]

        else:

            responses = [
                """Saya memahami bahwa Anda sedang mengalami tekanan akademik.

Menghadapi tugas, ujian, organisasi, dan berbagai tuntutan lainnya memang dapat menguras energi mental.

Cobalah fokus pada hal-hal yang dapat Anda kendalikan satu per satu.""",

                """Stres akademik merupakan pengalaman yang cukup umum di kalangan mahasiswa.

Meskipun terasa berat saat ini, ada banyak cara untuk mengelola tekanan tersebut secara bertahap dan sehat."""
            ]

        dispatcher.utter_message(text=random.choice(responses))
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

            responses = [
                """Merasa gugup sebelum presentasi adalah hal yang sangat wajar.

Cobalah berlatih beberapa kali sebelumnya dan fokus pada penyampaian pesan, bukan pada kemungkinan melakukan kesalahan.

Tidak harus sempurna untuk dapat tampil dengan baik.""",

                """Banyak orang mengalami kecemasan saat berbicara di depan umum.

Tarik napas perlahan sebelum mulai berbicara dan ingat bahwa audiens umumnya tidak memperhatikan kesalahan kecil yang mungkin Anda lakukan."""
            ]

        elif "masa depan" in message or "gagal" in message:

            responses = [
                """Kekhawatiran mengenai masa depan sering dialami banyak mahasiswa.

Ketika pikiran mulai dipenuhi berbagai kemungkinan buruk, cobalah mengalihkan fokus pada langkah kecil yang dapat dilakukan hari ini.

Masa depan dibangun dari tindakan yang dilakukan saat ini.""",

                """Takut gagal merupakan perasaan yang manusiawi.

Namun kegagalan bukanlah akhir dari perjalanan, melainkan bagian dari proses belajar dan berkembang.

Cobalah fokus pada usaha yang bisa Anda lakukan sekarang."""
            ]

        elif any(word in message for word in ["overthinking", "pikiran", "gelisah"]):

            responses = [
                """Overthinking dapat membuat pikiran terasa sangat lelah.

Saat hal tersebut terjadi, cobalah menuliskan semua hal yang sedang Anda pikirkan ke dalam catatan.

Teknik sederhana ini sering membantu mengurangi beban mental yang dirasakan.""",

                """Saya memahami bahwa pikiran yang terus berputar dapat terasa melelahkan.

Cobalah bertanya pada diri sendiri: apakah hal yang saya khawatirkan saat ini benar-benar terjadi, atau hanya kemungkinan yang saya bayangkan?

Pertanyaan tersebut dapat membantu melihat situasi dengan lebih objektif."""
            ]

        else:

            responses = [
                """Perasaan cemas dapat dialami oleh siapa saja, terutama ketika menghadapi ketidakpastian atau tekanan tertentu.

Anda dapat mencoba latihan pernapasan sederhana:

• Tarik napas selama 4 detik.
• Tahan selama 4 detik.
• Hembuskan perlahan selama 6 detik.

Ulangi beberapa kali hingga tubuh terasa lebih rileks.""",

                """Terima kasih sudah berbagi mengenai kecemasan yang Anda rasakan.

Saat merasa cemas, cobalah fokus pada hal-hal yang dapat Anda kendalikan saat ini dan hindari memikirkan terlalu banyak kemungkinan sekaligus.

Jika kecemasan berlangsung lama dan mengganggu aktivitas sehari-hari, pertimbangkan untuk berkonsultasi dengan psikolog atau konselor."""
            ]

        dispatcher.utter_message(text=random.choice(responses))
        return []