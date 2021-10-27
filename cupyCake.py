from rich.console import Console


class CupyCake:

    def __init__(self, script_title: str, steps: list):
        self.console = Console()
        self.script_title = script_title
        self.steps = steps

    def next(self, step) -> bool:
        step_name = step.__doc__
        step_cont = self.steps.index(step)
        self.console.print("")
        self.console.print(f"[blue bold]STEP {step_cont}[/blue bold]:: [blue]{step_name}[blue]")

        proceed = True
        while proceed:
            option = self.console.input(
                ">> Would you like to execute the step? [bright_black]([Y]es [N]o [Q]uit): [/bright_black]",
                markup=True)
            match option:
                case "y" | "Y" | "":
                    self.console.print(f"[green bold]Executing[/green bold] [cyan][STEP {step_cont}][/cyan]")
                    self.console.print("")
                    step()
                    break
                case "n" | "N":
                    self.console.print(f"[red bold]Skipping[/red bold] [cyan][STEP {step_cont}][/cyan]")
                    self.console.print("")
                    break
                case "q" | "Q":
                    self.console.print("[bright_black bold]Aborting the script execution[/bright_black bold]")
                    self.console.print("")
                    proceed = False
                case _:
                    self.console.print("[yellow bold]Invalid option. Please try again.[yellow bold]")
        return proceed

    def end(self) -> None:
        self.console.print("")
        self.console.print(f"[bright_magenta bold]CupCake[/bright_magenta bold] :: End of the execution of script [cyan]{self.script_title}[/cyan]")
        self.console.bell()

    def run(self) -> None:
        self.console.clear()
        self.console.print("")
        self.console.print(f"[bright_magenta bold]CupCake[/bright_magenta bold] :: Starting the execution of script [cyan]{self.script_title}[/cyan]")
        for step in self.steps:
            if not self.next(step):
                break
        self.end()

    stepCont = 1
