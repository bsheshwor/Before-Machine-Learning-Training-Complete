"""
[Factory Design Pattern] Build a logging system using the Factory Design Pattern.
Create a LoggerFactory class that generates different types of loggers (e.g., FileLogger,
ConsoleLogger, DatabaseLogger). Implement methods in each logger to write logs to
their respective destinations. Show how the Factory Design Pattern helps to decouple
the logging system from the application and allows for flexible log handling.
"""

from abc import ABC, abstractmethod

class Logger(ABC):
    """
    Abstract base class for different types of loggers.
    """
    @abstractmethod
    def write_log(self, message: str) -> None:
        """
        Abstract method to write logs to the respective destination.
        """
        pass

class FileLogger(Logger):
    def write_log(self, message: str) -> None:
        with open("log.txt", "a") as file:
            file.write(f"[FileLogger]: {message}\n")

class ConsoleLogger(Logger):
    def write_log(self, message: str) -> None:
        print(f"[ConsoleLogger]: {message}")

class DatabaseLogger(Logger):
    def write_log(self, message: str) -> None:
        # Code to write log to the database
        pass

class LoggerFactory:
    @staticmethod
    def create_logger(logger_type: str) -> Logger:
        if logger_type == "file":
            return FileLogger()
        elif logger_type == "console":
            return ConsoleLogger()
        elif logger_type == "database":
            return DatabaseLogger()
        else:
            raise ValueError("Invalid logger type!")

def main():
    logger_type = input("Enter logger type (file/console/database): ")
    logger = LoggerFactory.create_logger(logger_type)
    logger.write_log("This is a log message.")

if __name__ == "__main__":
    main()
