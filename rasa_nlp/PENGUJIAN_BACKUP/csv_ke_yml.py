"""Ubah hasil Google Form (CSV) menjadi file uji Rasa.
Pemakaian (CMD):  python csv_ke_yml.py jawaban_form.csv
Kolom 1 = Timestamp (diabaikan). Kolom 2-17 = skenario 1, kolom 18-33 = skenario 2,
dengan urutan situasi yang SAMA seperti pada daftar INTENT di bawah.
Setiap baris CSV = satu mahasiswa. Sel kosong dilewati."""
import csv, sys
INTENT = ["greet","stress_academic","anxiety","motivation","self_confidence","loneliness",
          "sleep_problem","depression_symptom","ask_tips","consultation","gratitude","goodbye",
          "inform","crisis_risk","ambiguous_distress","out_of_scope"]
rows = list(csv.reader(open(sys.argv[1], encoding="utf-8-sig")))[1:]
for sk in (1, 2):
    data = {i: [] for i in INTENT}
    for r in rows:
        for j, intent in enumerate(INTENT):
            idx = 1 + (sk - 1) * 16 + j
            if idx < len(r) and r[idx].strip():
                data[intent].append(" ".join(r[idx].split()).replace("\n", " "))
    out = ['version: "3.1"', "", "nlu:", ""]
    for i, ex in data.items():
        if ex:
            out += [f"- intent: {i}", "  examples: |"] + [f"    - {e}" for e in ex] + [""]
    fn = f"test_independen_mhs_skenario{sk}.yml"
    open(fn, "w", encoding="utf-8").write("\n".join(out))
    print(fn, sum(len(v) for v in data.values()), "kalimat")
