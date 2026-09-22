# ============================================================
# ACTIONS.PY
# Chatbot Dukungan Mahasiswa
# Rasa 3.x
# ============================================================

from typing import Any, Text, Dict, List

import random

from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher
from rasa_sdk.events import SlotSet


# ============================================================
# HELPER FUNCTIONS
# ============================================================

def contains_any(text: str, keywords: List[str]) -> bool:
    """
    Mengecek apakah salah satu keyword terdapat dalam teks.
    """
    text = text.lower()

    return any(keyword.lower() in text for keyword in keywords)


def detect_context(message: str) -> List[str]:
    """
    Mendeteksi konteks atau masalah yang muncul dalam pesan mahasiswa.

    Satu pesan dapat memiliki beberapa konteks sekaligus.
    """

    text = message.lower()

    contexts = []

    # --------------------------------------------------------
    # TUGAS
    # --------------------------------------------------------

    tugas_keywords = [
        "tugas",
        "deadline",
        "dead line",
        "tugas menumpuk",
        "tugas banyak",
        "laporan",
        "pekerjaan kuliah",
        "tugas kuliah",
        "tugas individu",
        "tugas kelompok",
    ]

    if contains_any(text, tugas_keywords):
        contexts.append("tugas")

    # --------------------------------------------------------
    # UJIAN
    # --------------------------------------------------------

    ujian_keywords = [
        "ujian",
        "uts",
        "uas",
        "kuis",
        "quiz",
        "ujian besok",
        "ujian minggu depan",
        "nilai ujian",
        "nilai",
        "soal",
        "tidak bisa menjawab",
    ]

    if contains_any(text, ujian_keywords):
        contexts.append("ujian")

    # --------------------------------------------------------
    # SKRIPSI
    # --------------------------------------------------------

    skripsi_keywords = [
        "skripsi",
        "proposal",
        "sempro",
        "seminar proposal",
        "sidang",
        "revisi",
        "dosen pembimbing",
        "bab 1",
        "bab 2",
        "bab 3",
        "bab i",
        "bab ii",
        "bab iii",
        "penelitian",
        "wisuda",
    ]

    if contains_any(text, skripsi_keywords):
        contexts.append("skripsi")

    # --------------------------------------------------------
    # ORGANISASI
    # --------------------------------------------------------

    organisasi_keywords = [
        "organisasi",
        "ukm",
        "bem",
        "hima",
        "kepanitiaan",
        "kepanitia",
        "acara kampus",
        "kegiatan kampus",
        "rapat organisasi",
        "anggota organisasi",
    ]

    if contains_any(text, organisasi_keywords):
        contexts.append("organisasi")

    # --------------------------------------------------------
    # PEKERJAAN
    # --------------------------------------------------------

    kerja_keywords = [
        "kerja",
        "bekerja",
        "part time",
        "part-time",
        "pekerjaan",
        "shift",
        "tempat kerja",
        "atasan",
        "karyawan",
        "job",
    ]

    if contains_any(text, kerja_keywords):
        contexts.append("kerja")

    # --------------------------------------------------------
    # KELUARGA
    # --------------------------------------------------------

    keluarga_keywords = [
        "keluarga",
        "orang tua",
        "ortu",
        "ayah",
        "ibu",
        "bapak",
        "mama",
        "papa",
        "kakak",
        "adik",
        "rumah",
        "keluarga saya",
        "masalah keluarga",
    ]

    if contains_any(text, keluarga_keywords):
        contexts.append("keluarga")

    # --------------------------------------------------------
    # TEMAN
    # --------------------------------------------------------

    teman_keywords = [
        "teman",
        "sahabat",
        "pertemanan",
        "circle",
        "lingkungan pertemanan",
        "teman kampus",
        "teman kuliah",
        "dijauhi",
        "bertengkar dengan teman",
    ]

    if contains_any(text, teman_keywords):
        contexts.append("teman")

    # --------------------------------------------------------
    # PRESENTASI
    # --------------------------------------------------------

    presentasi_keywords = [
        "presentasi",
        "presentasi kelas",
        "presentasi tugas",
        "berbicara di depan",
        "bicara di depan kelas",
        "public speaking",
        "berbicara di depan orang",
    ]

    if contains_any(text, presentasi_keywords):
        contexts.append("presentasi")

    # --------------------------------------------------------
    # OVERTHINKING
    # --------------------------------------------------------

    overthinking_keywords = [
        "overthinking",
        "terlalu banyak berpikir",
        "banyak pikiran",
        "pikiran saya penuh",
        "pikiran terus berjalan",
        "kepikiran",
        "memikirkan terus",
        "terus memikirkan",
        "pikiran tidak berhenti",
        "khawatir terus",
    ]

    if contains_any(text, overthinking_keywords):
        contexts.append("overthinking")

    # --------------------------------------------------------
    # KELELAHAN
    # --------------------------------------------------------

    lelah_keywords = [
        "lelah",
        "capek",
        "kelelahan",
        "sangat capek",
        "sangat lelah",
        "tidak punya tenaga",
        "kehabisan energi",
        "energi saya habis",
        "burnout",
        "jenuh",
        "terkuras",
    ]

    if contains_any(text, lelah_keywords):
        contexts.append("lelah")

    # --------------------------------------------------------
    # TIDUR
    # --------------------------------------------------------

    tidur_keywords = [
        "tidur",
        "sulit tidur",
        "susah tidur",
        "begadang",
        "kurang tidur",
        "tidur pagi",
        "tidur malam",
        "terbangun",
        "insomnia",
        "tidur berantakan",
    ]

    if contains_any(text, tidur_keywords):
        contexts.append("tidur")

    # --------------------------------------------------------
    # MOTIVASI
    # --------------------------------------------------------

    motivasi_keywords = [
        "motivasi",
        "tidak semangat",
        "nggak semangat",
        "tidak bersemangat",
        "gak semangat",
        "malas",
        "tidak punya semangat",
        "kehilangan semangat",
        "tidak ada semangat",
        "tidak ingin melakukan apa pun",
    ]

    if contains_any(text, motivasi_keywords):
        contexts.append("motivasi")

    # --------------------------------------------------------
    # PERCAYA DIRI
    # --------------------------------------------------------

    percaya_diri_keywords = [
        "tidak percaya diri",
        "nggak percaya diri",
        "gak percaya diri",
        "kurang percaya diri",
        "minder",
        "tidak yakin dengan diri",
        "tidak yakin dengan kemampuan",
        "meragukan diri",
        "merasa tidak mampu",
        "merasa bodoh",
        "tidak cukup baik",
    ]

    if contains_any(text, percaya_diri_keywords):
        contexts.append("percaya_diri")

    # --------------------------------------------------------
    # KESEPIAN
    # --------------------------------------------------------

    kesepian_keywords = [
        "kesepian",
        "sendirian",
        "merasa sendiri",
        "tidak punya teman",
        "tidak ada yang memahami",
        "tidak punya tempat cerita",
        "tidak punya tempat curhat",
        "tidak tahu harus cerita kepada siapa",
    ]

    if contains_any(text, kesepian_keywords):
        contexts.append("kesepian")

    return contexts


# ============================================================
# DETEKSI KONDISI EMOSIONAL
# ============================================================

def detect_emotional_state(message: str) -> List[str]:
    """
    Mendeteksi indikasi kondisi emosional berdasarkan bahasa
    yang digunakan mahasiswa.

    Ini bukan diagnosis medis.
    """

    text = message.lower()

    emotions = []

    # --------------------------------------------------------
    # CEMAS
    # --------------------------------------------------------

    anxiety_keywords = [
        "cemas",
        "khawatir",
        "takut",
        "gelisah",
        "panik",
        "deg-degan",
        "tegang",
        "tidak tenang",
        "was-was",
        "takut gagal",
    ]

    if contains_any(text, anxiety_keywords):
        emotions.append("cemas")

    # --------------------------------------------------------
    # SEDIH
    # --------------------------------------------------------

    sad_keywords = [
        "sedih",
        "menangis",
        "nangis",
        "kecewa",
        "hampa",
        "kosong",
        "murung",
        "tidak bahagia",
    ]

    if contains_any(text, sad_keywords):
        emotions.append("sedih")

    # --------------------------------------------------------
    # TERTEKAN
    # --------------------------------------------------------

    pressure_keywords = [
        "tertekan",
        "tekanan",
        "stres",
        "stress",
        "kewalahan",
        "terbebani",
        "beban",
        "semuanya berat",
        "terlalu berat",
    ]

    if contains_any(text, pressure_keywords):
        emotions.append("tertekan")

    # --------------------------------------------------------
    # BERSALAH
    # --------------------------------------------------------

    guilt_keywords = [
        "bersalah",
        "menyalahkan diri",
        "menyalahkan diri sendiri",
        "salah saya",
        "saya gagal",
        "merasa gagal",
        "kecewa dengan diri",
    ]

    if contains_any(text, guilt_keywords):
        emotions.append("bersalah")

    # --------------------------------------------------------
    # LELAH
    # --------------------------------------------------------

    tired_keywords = [
        "lelah",
        "capek",
        "kelelahan",
        "burnout",
        "jenuh",
        "tidak punya tenaga",
        "kehabisan energi",
    ]

    if contains_any(text, tired_keywords):
        emotions.append("lelah")

    # --------------------------------------------------------
    # PUTUS ASA
    # --------------------------------------------------------

    hopeless_keywords = [
        "putus asa",
        "tidak ada harapan",
        "tidak ada gunanya",
        "tidak sanggup lagi",
        "tidak kuat lagi",
        "ingin menyerah",
        "menyerah saja",
    ]

    if contains_any(text, hopeless_keywords):
        emotions.append("putus_asa")

    return emotions


# ============================================================
# DETEKSI KONDISI KRISIS
# ============================================================

def detect_crisis(message: str) -> bool:
    """
    Mendeteksi indikasi eksplisit mengenai keinginan bunuh diri
    atau menyakiti diri.

    Jika terdeteksi, chatbot tidak memberikan saran akademik biasa.
    """

    text = message.lower()

    crisis_keywords = [
        "ingin bunuh diri",
        "mau bunuh diri",
        "pengen bunuh diri",
        "akan bunuh diri",
        "berniat bunuh diri",
        "ingin mengakhiri hidup",
        "mau mengakhiri hidup",
        "pengen mengakhiri hidup",
        "ingin mati",
        "pengen mati",
        "mau mati",
        "lebih baik mati",
        "lebih baik saya mati",
        "lebih baik aku mati",
        "tidak ingin hidup",
        "tidak mau hidup",
        "tidak ingin melanjutkan hidup",
        "menyakiti diri",
        "menyakiti diri sendiri",
        "self harm",
        "self-harm",
        "melukai diri",
        "melukai diri sendiri",
    ]

    return contains_any(text, crisis_keywords)


# ============================================================
# MEMBUAT DESKRIPSI KONTEKS
# ============================================================

def get_context_text(contexts: List[str]) -> str:

    context_map = {
        "tugas": "tugas kuliah dan deadline",
        "ujian": "ujian atau penilaian",
        "skripsi": "skripsi atau penelitian",
        "organisasi": "kegiatan organisasi",
        "kerja": "pekerjaan",
        "keluarga": "situasi keluarga",
        "teman": "hubungan dengan teman",
        "presentasi": "presentasi atau berbicara di depan orang",
        "overthinking": "pikiran yang terus berputar",
        "lelah": "kelelahan",
        "tidur": "pola tidur",
        "motivasi": "motivasi dan semangat",
        "percaya_diri": "kepercayaan diri",
        "kesepian": "rasa kesepian",
    }

    descriptions = []

    for context in contexts:
        if context in context_map:
            descriptions.append(context_map[context])

    if not descriptions:
        return "beberapa hal yang sedang kamu hadapi"

    if len(descriptions) == 1:
        return descriptions[0]

    if len(descriptions) == 2:
        return f"{descriptions[0]} dan {descriptions[1]}"

    return ", ".join(descriptions[:-1]) + ", serta " + descriptions[-1]


# ============================================================
# ACTION UTAMA
# ============================================================

class ActionContextualSupport(Action):

    def name(self) -> Text:
        return "action_contextual_support"

    def run(
        self,
        dispatcher: CollectingDispatcher,
        tracker: Tracker,
        domain: Dict[Text, Any],
    ) -> List[Dict[Text, Any]]:

        # ----------------------------------------------------
        # AMBIL PESAN TERAKHIR USER
        # ----------------------------------------------------

        message = tracker.latest_message.get("text", "")

        if not message:
            dispatcher.utter_message(
                text=(
                    "Aku di sini untuk mendengarkan. "
                    "Ceritakan saja apa yang sedang kamu alami, "
                    "pelan-pelan juga tidak apa-apa."
                )
            )

            return []

        message = message.strip()

        # ----------------------------------------------------
        # CEK KRISIS TERLEBIH DAHULU
        # ----------------------------------------------------

        if detect_crisis(message):

            dispatcher.utter_message(
                text=(
                    "Aku senang kamu memilih untuk menceritakan ini. "
                    "Kalau saat ini kamu merasa ingin menyakiti diri, "
                    "mengakhiri hidup, atau merasa tidak aman dengan dirimu sendiri, "
                    "yang paling penting sekarang bukan menyelesaikan tugas atau "
                    "masalah kuliah terlebih dahulu, tetapi memastikan kamu tetap aman.\n\n"
                    
                    "Tolong jangan menghadapi keadaan ini sendirian. "
                    "Jika memungkinkan, segera hubungi orang yang kamu percaya "
                    "dan usahakan untuk berada di dekat orang lain. "
                    "Jauhkan juga benda atau tempat yang bisa digunakan untuk "
                    "menyakiti diri.\n\n"
                    
                    "Jika ada bahaya yang terasa segera atau kamu merasa tidak "
                    "mampu menjaga keselamatan diri, hubungi layanan darurat "
                    "setempat atau pergi ke fasilitas kesehatan terdekat. "
                    "Kamu tidak harus menyelesaikan semuanya sekarang. "
                    "Untuk saat ini, fokus pada satu hal: tetap aman dan "
                    "mendapatkan bantuan dari orang lain."
                )
            )

            return [
                SlotSet("last_topic", "krisis")
            ]

        # ----------------------------------------------------
        # DETEKSI INTENT
        # ----------------------------------------------------

        intent = tracker.latest_message.get("intent", {}).get(
            "name",
            ""
        )

        # ----------------------------------------------------
        # DETEKSI KONTEKS
        # ----------------------------------------------------

        contexts = detect_context(message)

        # ----------------------------------------------------
        # DETEKSI EMOSI
        # ----------------------------------------------------

        emotions = detect_emotional_state(message)

        # ----------------------------------------------------
        # SIMPAN TOPIK UTAMA KE SLOT
        # ----------------------------------------------------

        last_topic = contexts[0] if contexts else intent

        # ----------------------------------------------------
        # JIKA BANYAK KONTEKS
        # ----------------------------------------------------

        if len(contexts) >= 3:

            response = self._multi_context_response(
                message,
                contexts,
                emotions
            )

            dispatcher.utter_message(text=response)

            return [
                SlotSet("last_topic", last_topic)
            ]

        # ----------------------------------------------------
        # CERITA PANJANG / EMOSI KOMPLEKS
        # ----------------------------------------------------

        word_count = len(message.split())

        if word_count >= 40 or len(emotions) >= 2:

            response = self._complex_story_response(
                message,
                contexts,
                emotions
            )

            dispatcher.utter_message(text=response)

            return [
                SlotSet("last_topic", last_topic)
            ]

        # ----------------------------------------------------
        # SATU KONTEKS
        # ----------------------------------------------------

        response = self._single_context_response(
            contexts,
            emotions,
            message
        )

        dispatcher.utter_message(text=response)

        return [
            SlotSet("last_topic", last_topic)
        ]

    # ========================================================
    # RESPONS UNTUK BANYAK MASALAH
    # ========================================================

    def _multi_context_response(
        self,
        message: str,
        contexts: List[str],
        emotions: List[str],
    ) -> str:

        context_text = get_context_text(contexts)

        emotion_text = self._emotion_sentence(emotions)

        return (
            f"Aku menangkap bahwa akhir-akhir ini kamu sedang menghadapi "
            f"beberapa hal sekaligus, terutama {context_text}. "
            f"Kalau beberapa tekanan datang dalam waktu yang berdekatan, "
            f"wajar kalau semuanya terasa bercampur dan sulit menentukan "
            f"mana yang harus diselesaikan lebih dulu.\n\n"

            f"{emotion_text}\n\n"

            "Daripada memaksa diri menyelesaikan semuanya sekaligus, "
            "coba kita pisahkan masalahnya menjadi beberapa bagian. "
            "Pertama, lihat mana yang memiliki deadline paling dekat atau "
            "dampak paling besar jika tidak segera ditangani. "
            "Kedua, tentukan satu pekerjaan kecil yang realistis untuk "
            "dikerjakan sekarang. Tidak perlu langsung menyelesaikan "
            "semuanya. Ketiga, sisakan ruang untuk makan, minum, "
            "beristirahat, dan tidur karena tubuh dan pikiran yang terlalu "
            "lelah biasanya membuat masalah terasa semakin besar.\n\n"

            "Kamu juga tidak perlu menjadikan keadaan orang lain sebagai "
            "ukuran untuk menilai dirimu sendiri. Setiap mahasiswa memiliki "
            "beban, kondisi, dan kecepatan yang berbeda.\n\n"

            "Kalau kamu mau, kita bisa mengurai semuanya satu per satu. "
            "Dari semua yang sedang kamu hadapi sekarang, "
            "mana yang paling membuat kamu tertekan atau paling mendesak?"
        )

    # ========================================================
    # RESPONS CERITA KOMPLEKS
    # ========================================================

    def _complex_story_response(
        self,
        message: str,
        contexts: List[str],
        emotions: List[str],
    ) -> str:

        context_text = get_context_text(contexts)

        emotion_text = self._emotion_sentence(emotions)

        if contexts:

            context_intro = (
                f"Dari ceritamu, aku melihat bahwa ada beberapa hal yang "
                f"saling berkaitan, terutama {context_text}."
            )

        else:

            context_intro = (
                "Dari ceritamu, terlihat bahwa kamu sedang membawa cukup "
                "banyak beban dalam pikiran."
            )

        return (
            f"Terima kasih sudah menceritakannya dengan cukup lengkap. "
            f"{context_intro} "
            "Ketika beberapa persoalan muncul bersamaan, seseorang bisa "
            "merasa bingung, lelah, cemas, bahkan kesulitan menentukan "
            "harus mulai dari mana.\n\n"

            f"{emotion_text}\n\n"

            "Aku tidak ingin langsung mengatakan bahwa kamu hanya perlu "
            "\"lebih semangat\" atau \"jangan terlalu banyak berpikir\", "
            "karena dari ceritamu masalahnya memang cukup banyak dan "
            "saling berhubungan. Yang lebih membantu mungkin adalah "
            "mengurangi beban itu sedikit demi sedikit.\n\n"

            "Untuk sekarang, coba pilih tiga kategori sederhana: "
            "\"harus ditangani sekarang\", \"penting tetapi masih bisa "
            "ditunda\", dan \"belum perlu dipikirkan hari ini\". "
            "Masukkan setiap masalahmu ke salah satu kategori tersebut. "
            "Setelah itu, pilih hanya satu hal dari kategori pertama "
            "dan kerjakan dalam langkah yang sangat kecil.\n\n"

            "Misalnya, kalau tugas terasa terlalu besar, targetnya tidak "
            "harus langsung menyelesaikan tugas. Kamu bisa mulai dengan "
            "membuka dokumen, membaca instruksi, membuat tiga poin, atau "
            "mengerjakan bagian pertama selama beberapa menit.\n\n"

            "Dan kalau hari ini kemampuanmu hanya cukup untuk melakukan "
            "satu langkah kecil, itu tetap merupakan langkah. Kamu tidak "
            "harus membereskan seluruh hidupmu dalam satu hari.\n\n"

            "Kalau kamu ingin melanjutkan cerita, aku bisa membantumu "
            "mengurai masalah tersebut satu per satu. "
            "Menurutmu, bagian mana yang paling berat saat ini?"
        )

    # ========================================================
    # KALIMAT EMOSI
    # ========================================================

    def _emotion_sentence(
        self,
        emotions: List[str]
    ) -> str:

        if not emotions:

            return (
                "Aku juga bisa memahami bahwa situasi seperti ini dapat "
                "membuat pikiran terasa penuh, terutama ketika kamu belum "
                "menemukan cara yang pas untuk mengatasinya."
            )

        sentences = []

        if "cemas" in emotions:

            sentences.append(
                "Ada tanda bahwa kamu sedang membawa cukup banyak kekhawatiran "
                "dan kecemasan tentang apa yang akan terjadi."
            )

        if "sedih" in emotions:

            sentences.append(
                "Kamu juga terdengar sedang merasa sedih dan cukup terkuras "
                "secara emosional."
            )

        if "tertekan" in emotions:

            sentences.append(
                "Tekanan yang kamu rasakan juga terlihat cukup besar."
            )

        if "bersalah" in emotions:

            sentences.append(
                "Aku juga menangkap adanya rasa bersalah atau kecenderungan "
                "untuk menyalahkan diri sendiri."
            )

        if "lelah" in emotions:

            sentences.append(
                "Kelelahan yang kamu rasakan juga layak diperhatikan, "
                "bukan sekadar dianggap sebagai kurangnya kemauan."
            )

        if "putus_asa" in emotions:

            sentences.append(
                "Ada bagian dari ceritamu yang terdengar sangat berat dan "
                "membuatmu merasa kehilangan harapan."
            )

        return " ".join(sentences)

    # ========================================================
    # RESPONS SATU KONTEKS
    # ========================================================

    def _single_context_response(
        self,
        contexts: List[str],
        emotions: List[str],
        message: str,
    ) -> str:

        # ----------------------------------------------------
        # TUGAS
        # ----------------------------------------------------

        if "tugas" in contexts:

            responses = [

                (
                    "Kalau tugas sudah menumpuk, wajar kalau kamu merasa "
                    "bingung bahkan sebelum mulai mengerjakannya. "
                    "Coba jangan melihat semua tugas sebagai satu beban besar. "
                    "Tuliskan dulu semua tugas beserta deadline-nya, "
                    "kemudian pilih satu yang paling dekat atau paling "
                    "membutuhkan waktu.\n\n"
                    
                    "Setelah itu, pecah tugas tersebut menjadi bagian kecil. "
                    "Target awalnya tidak harus selesai. Bisa cukup membuka "
                    "materi, membuat kerangka, atau mengerjakan satu bagian. "
                    "Kadang langkah pertama memang yang paling berat."
                ),

                (
                    "Aku paham kenapa tugas yang menumpuk bisa membuatmu "
                    "merasa tertekan. Ketika semuanya terlihat harus "
                    "diselesaikan sekaligus, otak justru bisa merasa kewalahan.\n\n"
                    
                    "Coba buat daftar singkat: mana yang harus selesai hari ini, "
                    "mana yang bisa dikerjakan besok, dan mana yang masih "
                    "punya waktu. Setelah itu pilih satu pekerjaan kecil "
                    "dan fokus pada pekerjaan tersebut tanpa memikirkan "
                    "semua tugas lainnya terlebih dahulu."
                ),
            ]

            return random.choice(responses)

        # ----------------------------------------------------
        # UJIAN
        # ----------------------------------------------------

        if "ujian" in contexts:

            return (
                "Rasa cemas menjelang ujian cukup bisa dimengerti, terutama "
                "kalau kamu merasa persiapannya belum cukup. Daripada terus "
                "memikirkan kemungkinan mendapatkan nilai buruk, coba "
                "alihkan perhatian ke hal yang masih bisa kamu kendalikan.\n\n"

                "Pilih materi yang paling penting, buat daftar topik yang "
                "perlu dipelajari, lalu mulai dari satu topik. Kamu juga "
                "bisa menggunakan latihan soal untuk mengetahui bagian "
                "mana yang belum kamu pahami.\n\n"

                "Tidak perlu menunggu sampai merasa benar-benar siap untuk "
                "mulai belajar. Persiapan sedikit demi sedikit tetap lebih "
                "berguna daripada terus memikirkan kemungkinan gagal."
            )

        # ----------------------------------------------------
        # SKRIPSI
        # ----------------------------------------------------

        if "skripsi" in contexts:

            return (
                "Skripsi memang bisa terasa berat karena bukan hanya soal "
                "mengerjakan tugas, tetapi juga membutuhkan keputusan, "
                "revisi, membaca banyak materi, dan menghadapi ketidakpastian. "
                "Kalau semuanya dipikirkan sekaligus, wajar kalau kamu "
                "merasa buntu.\n\n"

                "Coba kecilkan targetnya. Jangan mulai dengan target "
                "\"harus menyelesaikan skripsi\", tetapi misalnya "
                "\"hari ini mencari dua referensi\", "
                "\"menyelesaikan satu paragraf\", atau "
                "\"memperbaiki satu bagian hasil revisi\".\n\n"

                "Kalau ada revisi dari dosen, kerjakan satu poin revisi "
                "terlebih dahulu sebelum berpindah ke poin berikutnya. "
                "Kemajuan kecil tetap merupakan kemajuan."
            )

        # ----------------------------------------------------
        # PRESENTASI
        # ----------------------------------------------------

        if "presentasi" in contexts:

            return (
                "Kalau kamu gugup menghadapi presentasi, kamu tidak harus "
                "menghilangkan rasa gugup itu sepenuhnya. Target yang lebih "
                "realistis adalah tetap bisa menyampaikan materi meskipun "
                "ada rasa tegang.\n\n"

                "Coba siapkan tiga hal utama yang benar-benar ingin kamu "
                "sampaikan. Latih pembukaan dan penutupnya beberapa kali, "
                "karena dua bagian tersebut sering membantu membuat "
                "presentasi terasa lebih terarah.\n\n"

                "Sebelum mulai, tarik napas perlahan dan beri dirimu "
                "beberapa detik untuk melihat materi. Kamu tidak harus "
                "terlihat sempurna di depan orang lain."
            )

        # ----------------------------------------------------
        # ORGANISASI / KERJA
        # ----------------------------------------------------

        if "organisasi" in contexts or "kerja" in contexts:

            return (
                "Menjalani kuliah sambil memiliki tanggung jawab organisasi "
                "atau pekerjaan memang bisa membuat waktu dan energi terasa "
                "terbagi. Kalau semua kegiatan memiliki tuntutan masing-masing, "
                "kamu mungkin merasa harus selalu siap untuk semuanya.\n\n"

                "Coba lihat kembali mana tanggung jawab yang benar-benar "
                "harus kamu selesaikan sendiri dan mana yang bisa dibagi "
                "atau dikomunikasikan kepada orang lain. Menentukan batas "
                "bukan berarti kamu tidak bertanggung jawab.\n\n"

                "Kalau jadwal sudah terlalu penuh, mungkin ada baiknya "
                "menentukan prioritas sementara agar kuliah, pekerjaan, "
                "dan kebutuhan pribadi tetap memiliki ruang."
            )

        # ----------------------------------------------------
        # KELUARGA
        # ----------------------------------------------------

        if "keluarga" in contexts:

            return (
                "Masalah keluarga bisa terasa lebih berat karena biasanya "
                "kita tidak bisa begitu saja memisahkan masalah tersebut "
                "dari kehidupan kuliah. Kalau pikiranmu terus terbawa oleh "
                "situasi di rumah, wajar kalau konsentrasi dan energi ikut "
                "terpengaruh.\n\n"

                "Coba bedakan hal yang memang berada dalam kendalimu "
                "dengan hal yang berada di luar kendalimu. Kamu tidak harus "
                "menyelesaikan semua persoalan keluarga sendirian.\n\n"

                "Kalau ada orang yang cukup kamu percaya, berbicara dengan "
                "mereka mungkin bisa membuat beban terasa sedikit lebih ringan."
            )

        # ----------------------------------------------------
        # TEMAN
        # ----------------------------------------------------

        if "teman" in contexts or "kesepian" in contexts:

            return (
                "Merasa sendirian atau tidak memiliki tempat yang nyaman "
                "untuk bercerita bisa membuat masalah terasa jauh lebih berat. "
                "Perasaan tersebut tidak berarti kamu lemah atau gagal "
                "bersosialisasi.\n\n"

                "Kalau belum siap menceritakan semuanya kepada seseorang, "
                "kamu bisa memulainya dari hal kecil. Misalnya menghubungi "
                "satu teman yang cukup dipercaya dan mengatakan bahwa kamu "
                "sedang membutuhkan seseorang untuk mendengarkan.\n\n"

                "Kamu tidak harus langsung menceritakan semua masalah. "
                "Memiliki satu percakapan yang aman pun sudah bisa menjadi "
                "awal yang baik."
            )

        # ----------------------------------------------------
        # OVERTHINKING
        # ----------------------------------------------------

        if "overthinking" in contexts:

            return (
                "Kalau pikiran terus berputar, mencoba memaksanya berhenti "
                "seketika justru kadang membuatnya semakin kuat. Kamu bisa "
                "mencoba menuliskan apa yang sedang dipikirkan lalu "
                "memisahkan antara hal yang bisa kamu kendalikan dan "
                "hal yang belum bisa kamu kendalikan.\n\n"

                "Untuk hal yang bisa dikendalikan, tentukan satu tindakan "
                "kecil. Untuk hal yang belum bisa dikendalikan, beri dirimu "
                "izin untuk tidak menyelesaikannya sekarang.\n\n"

                "Kalau pikiran muncul saat akan tidur, kamu juga bisa "
                "menuliskan kekhawatiran tersebut terlebih dahulu agar "
                "tidak harus terus mengingatnya di kepala."
            )

        # ----------------------------------------------------
        # TIDUR
        # ----------------------------------------------------

        if "tidur" in contexts:

            return (
                "Kalau pola tidurmu mulai berantakan, tubuh dan pikiran "
                "bisa menjadi lebih sulit berkonsentrasi sehingga tugas "
                "atau masalah terasa semakin berat.\n\n"

                "Kalau memungkinkan, coba mulai dengan perubahan kecil. "
                "Misalnya menentukan waktu tidur yang lebih konsisten, "
                "mengurangi penggunaan perangkat sebelum tidur, dan "
                "menghindari membawa pekerjaan kuliah ke tempat tidur.\n\n"

                "Kalau sulit tidur terus berlangsung atau sangat mengganggu "
                "aktivitas sehari-hari, pertimbangkan untuk membicarakannya "
                "dengan tenaga kesehatan."
            )

        # ----------------------------------------------------
        # MOTIVASI
        # ----------------------------------------------------

        if "motivasi" in contexts:

            return (
                "Kehilangan motivasi tidak selalu berarti kamu malas. "
                "Kadang seseorang kehilangan semangat karena terlalu lelah, "
                "terlalu banyak tekanan, atau terlalu lama memaksakan diri.\n\n"

                "Daripada menunggu motivasi datang terlebih dahulu, coba "
                "mulai dari aktivitas yang sangat kecil. Misalnya belajar "
                "selama 10 menit, membaca satu halaman, atau menyelesaikan "
                "satu bagian tugas.\n\n"

                "Tujuannya bukan langsung menjadi sangat produktif, "
                "tetapi membangun kembali rasa bahwa kamu masih mampu "
                "bergerak sedikit demi sedikit."
            )

        # ----------------------------------------------------
        # PERCAYA DIRI
        # ----------------------------------------------------

        if "percaya_diri" in contexts:

            return (
                "Kalau kamu sering merasa tidak cukup baik atau terus "
                "membandingkan diri dengan orang lain, coba ingat bahwa "
                "pencapaian orang lain tidak menunjukkan seluruh proses "
                "yang mereka jalani.\n\n"

                "Coba ubah fokus dari \"apakah aku lebih baik dari orang lain?\" "
                "menjadi \"apa satu hal yang bisa aku lakukan dengan lebih "
                "baik hari ini?\".\n\n"

                "Kesalahan juga tidak otomatis membuktikan bahwa kamu tidak "
                "mampu. Kesalahan bisa menjadi informasi tentang bagian "
                "mana yang masih perlu dipelajari atau dilatih."
            )

        # ----------------------------------------------------
        # DEFAULT
        # ----------------------------------------------------

        return (
            "Terima kasih sudah mau bercerita. Aku bisa memahami bahwa "
            "situasi yang sedang kamu hadapi mungkin tidak mudah, terutama "
            "kalau kamu sudah memikirkannya cukup lama.\n\n"

            "Kamu tidak harus langsung menemukan jawaban untuk semuanya. "
            "Coba mulai dengan mengidentifikasi satu hal yang paling "
            "mengganggu pikiranmu saat ini. Setelah itu kita bisa "
            "membahasnya secara perlahan.\n\n"

            "Kalau kamu nyaman, ceritakan sedikit lagi tentang apa yang "
            "paling membuatmu merasa berat sekarang."
        )


# ============================================================
# ACTION STRESS
# ============================================================

class ActionStressAdvice(Action):

    def name(self) -> Text:
        return "action_stress_advice"

    def run(
        self,
        dispatcher: CollectingDispatcher,
        tracker: Tracker,
        domain: Dict[Text, Any],
    ) -> List[Dict[Text, Any]]:

        message = tracker.latest_message.get("text", "")

        if detect_crisis(message):

            dispatcher.utter_message(
                text=(
                    "Aku ingin memastikan keselamatanmu terlebih dahulu. "
                    "Kalau tekanan yang kamu rasakan sampai membuatmu ingin "
                    "menyakiti diri atau mengakhiri hidup, jangan hadapi "
                    "situasi tersebut sendirian. Segera hubungi orang yang "
                    "kamu percaya dan cari bantuan langsung dari layanan "
                    "darurat atau fasilitas kesehatan terdekat jika kamu "
                    "merasa tidak aman."
                )
            )

            return [
                SlotSet("last_topic", "krisis")
            ]

        contexts = detect_context(message)

        emotions = detect_emotional_state(message)

        action = ActionContextualSupport()

        response = action._single_context_response(
            contexts,
            emotions,
            message
        )

        dispatcher.utter_message(text=response)

        last_topic = contexts[0] if contexts else "stress"

        return [
            SlotSet("last_topic", last_topic)
        ]


# ============================================================
# ACTION ANXIETY
# ============================================================

class ActionAnxietyAdvice(Action):

    def name(self) -> Text:
        return "action_anxiety_advice"

    def run(
        self,
        dispatcher: CollectingDispatcher,
        tracker: Tracker,
        domain: Dict[Text, Any],
    ) -> List[Dict[Text, Any]]:

        message = tracker.latest_message.get("text", "")

        if detect_crisis(message):

            dispatcher.utter_message(
                text=(
                    "Aku ingin memastikan kamu tetap aman. "
                    "Kalau kecemasan yang kamu rasakan disertai keinginan "
                    "untuk menyakiti diri atau mengakhiri hidup, cobalah "
                    "segera mendekati orang yang kamu percaya dan jangan "
                    "berada sendirian. Jika ada risiko yang terasa segera, "
                    "hubungi layanan darurat setempat atau pergi ke "
                    "fasilitas kesehatan terdekat."
                )
            )

            return [
                SlotSet("last_topic", "krisis")
            ]

        contexts = detect_context(message)

        emotions = detect_emotional_state(message)

        action = ActionContextualSupport()

        response = action._single_context_response(
            contexts,
            emotions,
            message
        )

        dispatcher.utter_message(text=response)

        last_topic = contexts[0] if contexts else "cemas"

        return [
            SlotSet("last_topic", last_topic)
        ]