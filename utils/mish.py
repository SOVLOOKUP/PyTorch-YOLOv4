import torch

class Mish(torch.nn.Module):
    def __init__(self):
        super().__init__()

    def forward(self,x):
        x = x*(torch.tanh(torch.nn.functional.softplus(x)))
        return x