from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher
import random


# =====================================
# STRESS ACADEMIC ACTION (UPGRADED)
# =====================================
class ActionStressAdvice(Action):

    def name(self) -> str:
        return "action_stress_advice"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain):

        message = tracker.latest_message.get("text", "").lower()

        responses = []

        # =========================
        # DEADLINE / TUGAS
        # =========================
        if any(word in message for word in ["deadline", "tugas", "menumpuk"]):

            responses = [
                """Aku ngerti banget, situasi tugas yang menumpuk itu bisa bikin kepala penuh.

Kita coba pecah jadi bagian kecil dulu ya, jangan dipikirkan sekaligus.

Kalau kamu urutkan sekarang, tugas mana yang paling mendesak?""",

                """Tekanan deadline itu memang bikin energi cepat terkuras.

Coba kita ambil satu langkah kecil dulu biar lebih ringan.

Dari semua tugas itu, mana yang paling bikin kamu stuck?""",

                """Kalau semua terasa numpuk, biasanya bukan tugasnya yang masalah, tapi beban pikirannya.

Kita urai pelan-pelan ya.

Yang paling dekat deadline-nya apa sekarang?""",

                """Aku paham ini terasa berat banget.

Tapi kamu nggak harus bereskan semuanya sekaligus.

Sekarang, tugas apa yang paling bikin kamu kepikiran malam ini?"""
            ]

        # =========================
        # UJIAN / NILAI
        # =========================
        elif any(word in message for word in ["ujian", "nilai", "ipk"]):

            responses = [
                """Wajar kalau ujian bikin cemas, itu tanda kamu peduli.

Tapi kita fokus ke apa yang bisa dipelajari hari ini saja.

Mata kuliah apa yang paling bikin kamu khawatir?""",

                """Nilai itu penting, tapi bukan satu-satunya penentu masa depanmu.

Coba kita lihat satu per satu biar lebih ringan.

Sekarang yang paling bikin kamu takut apa?""",

                """Aku paham tekanan akademik itu nggak mudah.

Tapi kamu nggak harus sempurna untuk berhasil.

Bagian mana dari ujian yang paling bikin kamu cemas?""",

                """Kadang yang bikin berat itu bukan ujiannya, tapi pikirannya.

Coba kita pelan-pelan urai.

Kamu lebih takut gagal atau tidak siap?"""
            ]

        # =========================
        # SKRIPSI / REVISI
        # =========================
        elif any(word in message for word in ["skripsi", "revisi"]):

            responses = [
                """Skripsi memang sering jadi fase paling melelahkan.

Tapi kamu sudah sampai sejauh ini, itu luar biasa.

Sekarang kamu lagi stuck di bagian mana?""",

                """Revisi itu bagian dari proses, bukan tanda kamu gagal.

Kita pecah jadi lebih kecil biar lebih mudah.

Bab apa yang sedang kamu kerjakan sekarang?""",

                """Aku tahu ini bisa bikin frustrasi.

Tapi pelan-pelan kamu pasti bisa lewat ini.

Bagian mana yang paling bikin kamu buntu?""",

                """Skripsi memang kadang terasa seperti tidak ada habisnya.

Tapi kamu sudah lebih dekat ke garis akhir.

Sekarang apa yang paling menghambatmu?"""
            ]

        # =========================
        # BURNOUT / CAPEK
        # =========================
        elif any(word in message for word in ["burnout", "kelelahan", "capek", "lelah"]):

            responses = [
                """Sepertinya kamu sudah sangat lelah, bukan cuma fisik tapi juga mental.

Kamu butuh jeda, bukan tambahan tekanan.

Kapan terakhir kali kamu benar-benar istirahat?""",

                """Kalau sudah capek seperti ini, itu tanda tubuhmu minta berhenti sebentar.

Tidak apa-apa berhenti dulu.

Apa yang paling menguras energimu akhir-akhir ini?""",

                """Aku bisa merasakan kamu sedang sangat lelah.

Kamu nggak harus kuat terus.

Sekarang yang paling bikin kamu habis energi apa?""",

                """Burnout itu bukan malas, tapi tanda kamu terlalu lama bertahan.

Kita pelan-pelan ya.

Apa aktivitas yang paling bikin kamu terkuras?"""
            ]

        # =========================
        # DEFAULT STRESS
        # =========================
        else:

            responses = [
                """Aku dengar kamu lagi ada tekanan akademik.

Kita pelan-pelan urai ya, nggak perlu semuanya sekaligus.

Apa yang paling berat sekarang?""",

                """Kondisi seperti ini wajar dialami banyak mahasiswa.

Kita coba lihat satu per satu biar lebih ringan.

Hal apa yang paling mengganggu pikiranmu?""",

                """Aku di sini menemani kamu.

Kita tidak perlu menyelesaikan semuanya sekarang.

Cerita sedikit, apa yang paling bikin kamu tertekan?""",

                """Kadang semuanya terasa terlalu banyak.

Tapi kita bisa mulai dari satu hal kecil.

Apa yang paling mendesak saat ini?"""
            ]

        dispatcher.utter_message(text=random.choice(responses))
        return []


# =====================================
# ANXIETY ACTION (UPGRADED)
# =====================================
class ActionAnxietyAdvice(Action):

    def name(self) -> str:
        return "action_anxiety_advice"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain):

        message = tracker.latest_message.get("text", "").lower()

        responses = []

        # =========================
        # PRESENTASI
        # =========================
        if "presentasi" in message:

            responses = [
                """Gugup sebelum presentasi itu sangat manusiawi.

Kamu nggak harus sempurna untuk bisa menyampaikan dengan baik.

Bagian mana yang paling bikin kamu takut?""",

                """Banyak orang juga merasakan hal yang sama.

Yang penting kamu paham isi, bukan sempurna.

Kamu lebih takut lupa atau dinilai orang?""",

                """Rasa deg-degan itu tanda kamu peduli.

Coba kita pelan-pelan atur.

Apa yang paling kamu khawatirkan saat presentasi?"""
            ]

        # =========================
        # MASA DEPAN / GAGAL
        # =========================
        elif "masa depan" in message or "gagal" in message:

            responses = [
                """Kekhawatiran soal masa depan itu wajar banget.

Tapi kita nggak perlu memikirkan semuanya sekaligus.

Apa yang paling bikin kamu takut sekarang?""",

                """Takut gagal itu bagian dari manusia.

Tapi gagal bukan akhir cerita.

Hal apa yang paling kamu khawatirkan?""",

                """Kadang pikiran kita lari terlalu jauh ke depan.

Kita fokus hari ini dulu ya.

Sekarang kamu paling takut apa?"""
            ]

        # =========================
        # OVERTHINKING
        # =========================
        elif any(word in message for word in ["overthinking", "pikiran", "gelisah"]):

            responses = [
                """Overthinking bisa sangat melelahkan.

Coba kita turunkan pelan-pelan beban pikiranmu.

Apa yang paling sering muncul di pikiranmu?""",

                """Pikiran yang berputar terus itu menguras energi.

Coba tulis apa yang kamu rasakan.

Hal apa yang paling mengganggu?""",

                """Aku paham itu nggak mudah.

Tapi kita bisa urai satu per satu.

Apa yang paling bikin kamu gelisah?"""
            ]

        # =========================
        # DEFAULT ANXIETY
        # =========================
        else:

            responses = [
                """Cemas itu wajar, apalagi kalau banyak tekanan.

Kita tarik napas dulu pelan-pelan ya.

Apa yang sedang kamu rasakan sekarang?""",

                """Aku di sini untuk kamu.

Kita pelan-pelan aja.

Hal apa yang paling bikin kamu tidak tenang?""",

                """Terima kasih sudah cerita.

Kita coba pahami bersama.

Sekarang apa yang paling kamu khawatirkan?"""
            ]

        dispatcher.utter_message(text=random.choice(responses))
        return []