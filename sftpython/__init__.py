"""SFTP functionality"""
import sys

if sys.version_info >= (3, 8, 0):
    import importlib.metadata

    __version__ = importlib.metadata.version(__package__ or __name__)
else:
    from pkg_resources import get_distribution

    __version__ = get_distribution(__package__ or __name__).version


class Connection:  # pylint: disable=too-few-public-methods
    """Connection"""
