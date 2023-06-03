.class Lair/Tsoclient/AppEntry$2;
.super Ljava/lang/Object;
.source "AppEntry.java"

# interfaces
.implements Landroid/content/DialogInterface$OnCancelListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lair/Tsoclient/AppEntry;->showDialog(ILjava/lang/String;II)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lair/Tsoclient/AppEntry;


# direct methods
.method constructor <init>(Lair/Tsoclient/AppEntry;)V
    .locals 0

    .prologue
    .line 179
    iput-object p1, p0, Lair/Tsoclient/AppEntry$2;->this$0:Lair/Tsoclient/AppEntry;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCancel(Landroid/content/DialogInterface;)V
    .locals 4
    .param p1, "dialog"    # Landroid/content/DialogInterface;

    .prologue
    const/4 v3, 0x0

    .line 182
    invoke-static {}, Lair/Tsoclient/AppEntry;->access$100()Lair/Tsoclient/AppEntry;

    move-result-object v0

    invoke-static {}, Lair/Tsoclient/AppEntry;->access$200()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x1

    invoke-static {v0, v1, v3, v3, v2}, Lcom/adobe/air/InstallOfferPingUtils;->PingAndExit(Landroid/app/Activity;Ljava/lang/String;ZZZ)V

    .line 183
    return-void
.end method
