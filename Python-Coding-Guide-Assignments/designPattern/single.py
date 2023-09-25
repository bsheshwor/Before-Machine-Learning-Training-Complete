"""
[Singleton Design Pattern] Implement a configuration manager using the Singleton
Design Pattern. The configuration manager should read configuration settings from a
file and provide access to these settings throughout the application. Demonstrate howthe Singleton Design Pattern ensures that there is only one instance of the
configuration manager, preventing unnecessary multiple reads of the configuration file.
"""

class ConfigurationManager:
    """
    Configuration manager using the Singleton Design Pattern.
    """
    _instance = None

    def __new__(cls):
        if cls._instance is None:
            cls._instance = super(ConfigurationManager, cls).__new__(cls)
            cls._instance.load_configuration()
        return cls._instance

    def load_configuration(self) -> None:
        # Code to read configuration settings from a file
        # and store them as attributes of the instance
        self.setting1 = "value1"
        self.setting2 = "value2"

    def get_setting(self, setting_name: str) -> str:
        """
        Get the value of a configuration setting.

        Parameters:
            setting_name (str): The name of the configuration setting.

        Returns:
            str: The value of the configuration setting.
        """
        return getattr(self, setting_name, None)

def main():
    config_manager1 = ConfigurationManager()
    config_manager2 = ConfigurationManager()

    print(config_manager1.get_setting("setting1"))  # Output: value1
    print(config_manager2.get_setting("setting2"))  # Output: value2

    # Both config_manager1 and config_manager2 point to the same instance
    print(config_manager1 is config_manager2)  # Output: True

if __name__ == "__main__":
    main()
