"""Rekap hasil `rasa test nlu` menjadi tabel siap salin ke Word.
Pemakaian (CMD):  python rekap_hasil.py results\\test_internal
"""
import json, sys, os
folder = sys.argv[1]
rep = json.load(open(os.path.join(folder, "intent_report.json"), encoding="utf-8"))
f = lambda x: f"{x:.2f}".replace(".", ",")
print(f"{'Intent':22}{'Uji':>5}{'Precision':>11}{'Recall':>9}{'F1':>7}")
for k, v in rep.items():
    if isinstance(v, dict) and k not in ("macro avg", "weighted avg", "micro avg"):
        print(f"{k:22}{int(v['support']):>5}{f(v['precision']):>11}{f(v['recall']):>9}{f(v['f1-score']):>7}")
for k in ("macro avg", "weighted avg"):
    v = rep[k]; print(f"{k:22}{int(v['support']):>5}{f(v['precision']):>11}{f(v['recall']):>9}{f(v['f1-score']):>7}")
total = int(rep["macro avg"]["support"])
acc = rep.get("accuracy", rep.get("micro avg", {}).get("f1-score"))
print(f"\nAccuracy: {acc*100:.2f}% ({round(acc*total)} dari {total} kalimat benar)".replace(".", ",", 1))
ep = os.path.join(folder, "intent_errors.json")
if os.path.exists(ep):
    errs = json.load(open(ep, encoding="utf-8"))
    print(f"\nKalimat salah klasifikasi: {len(errs)}")
    for e in errs:
        print(f"- \"{e['text']}\" | sebenarnya: {e['intent']} | prediksi: {e['intent_prediction']['name']} "
              f"({e['intent_prediction']['confidence']:.2f})")
