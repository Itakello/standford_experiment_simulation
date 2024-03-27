from abc import ABC, abstractmethod


class DocumentSerializable(ABC):

    @abstractmethod
    def to_document(self) -> dict:
        """
        Converts the object to a dictionary representation.

        Returns:
            dict: A dictionary representation of the object.
        """
        pass
