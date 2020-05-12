from GUI import GUI
from superprimeEEG import SuperPrime

the_gui = GUI()

if the_gui.saved_changes.get() == 1:
    the_experiment = SuperPrime()
