.class public Lcom/adobe/air/AIRService$DummyBinder;
.super Landroid/os/Binder;
.source "AIRService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/AIRService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "DummyBinder"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/AIRService;


# direct methods
.method public constructor <init>(Lcom/adobe/air/AIRService;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/air/AIRService;

    .prologue
    .line 141
    iput-object p1, p0, Lcom/adobe/air/AIRService$DummyBinder;->this$0:Lcom/adobe/air/AIRService;

    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    return-void
.end method


# virtual methods
.method getService()Lcom/adobe/air/AIRService;
    .locals 1

    .prologue
    .line 145
    iget-object v0, p0, Lcom/adobe/air/AIRService$DummyBinder;->this$0:Lcom/adobe/air/AIRService;

    return-object v0
.end method
