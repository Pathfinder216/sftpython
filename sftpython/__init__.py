"""SFTP functionality"""
import importlib.metadata

__version__ = importlib.metadata.version(__package__ or __name__)


class Connection:  # pylint: disable=too-few-public-methods
    """Connection"""
